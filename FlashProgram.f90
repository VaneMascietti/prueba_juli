! Código desenvolvido no Rio (Novembro 2014-Dezembro 2016), starting as a variation of "Flash Sur" version Nov 6

! Listado de commons utilizados, que podrían pasar a un módulo:
!   COMMON /CRIT/TC(nco),PC(nco),DCeos(nco),omg(nco)
!	COMMON /COMPONENTS/ ac(nco),b(nco),delta1(nco),rk(nco),Kij_or_K0,NTDEP
!	COMMON /MODEL/ NMODEL
!	COMMON /rule/ncomb

!	COMMON /bcross/bij(nco,nco)
!	COMMON /Tdep/ Kinf,Tstar 

 program calc_flash
!USE PHIS
!USE zTVTERMOm
    implicit DOUBLE PRECISION (A-H,O-Z)
    OPEN(1,FILE='flashIN.txt')
    OPEN(2,FILE='flashOUT.txt')
    OPEN(3,FILE='flashPvbeta.txt')
    OPEN(4,FILE='flashP.txt')
    OPEN(7,FILE='flashComp.txt')
    OPEN(8,FILE='flashSL.txt')
    read(1,*) N
    call readcase(n)
END program calc_flash

subroutine readcase(n)
USE PHIS
USE zTVTERMOm
    implicit DOUBLE PRECISION (A-H,O-Z)
    PARAMETER (nco=64, RGAS=0.08314472d0)
    LOGICAL FIRST, direct, First_Flash
	dimension z(n)
    CHARACTER*4 spec
	DOUBLE PRECISION Kinf
        ! pure compound physical constants
        real*8, dimension(n) :: tcn
        real*8, dimension(n) :: pcn
        real*8, dimension(n) :: omgn
        DOUBLE PRECISION, dimension(nco) :: Ttp, Ptp, Vs_Vl, C1, C2, C3, rNC
        DOUBLE PRECISION, dimension(n) :: Ttpn, Ptpn, Vs_Vln, C1n, C2n, C3n, rNCn !agregado

        ! eos parameters
        real*8, dimension(n) :: acn  ! in bar*(L/mol)**2
        real*8, dimension(n) :: bn   ! in L/mol
        real*8, dimension(n) :: delta1n  !only required for RKPR
        real*8, dimension(n) :: k_or_mn  ! k for RKPR ; m for SRK/PR

        ! interaction parameters matrices
        real*8, dimension(n,n) :: Kij_or_K0n, Lijn
        real*8, dimension(n,n) :: Tstarn   

    ! interaction parameters matrices
    real*8, dimension(nco,nco) :: Kij_or_K0, Lij, Tstar

    real*8, dimension(nco) :: x , y  ! composition of liquid and vapour (molar fractions)

        ! Auxiliary variables not used here, but required to call zTVTERMO
        real*8, dimension(n) :: PHILOG
        real*8, dimension(n, n) :: FUGN

        ! starting and finishing times for registering computing time
        REAL*8  Itime1, Itime2, Itime3, Itime4

        COMMON /CRIT/TC(nco),PC(nco),DCeos(nco),omg(nco)
	    COMMON /MODEL/ NMODEL
	    COMMON /Vshift/ iVshift, Vs(nco)    ! added June 2016
	    COMMON /COMPONENTS/ ac(nco),b(nco),delta1(nco),rk_or_m(nco),Kij_or_K0,NTDEP
	    COMMON /rule/ncomb
	    COMMON /bcross/bij(nco,nco)
	    COMMON /Tdep/ Kinf,Tstar    
	    COMMON /lforin/lij
        COMMON/SOLID/Ttp,Ptp,Vs_Vl,C1,C2,C3,rNC

        !read(1,*) Nplus ! order of comp. from which the plus fraction will be computed,
                        ! to inform yNplus and xNplus in flashPvbeta.txt
                        
        read(1,*) spec ! TP: TPz(K,bar) ; TV: Tvz(K,L/mol)
        
        READ(1,*) (z(j),j=1,N)
        !Zplus = sum(z(Nplus:N))
        !WRITE (3,*) ' The plus fraction from component ',Nplus,' is ',Zplus
        SELECT CASE (spec)
        CASE ('TP')
            First_Flash = .TRUE.
            IF (FIRST_FLASH) THEN
                read(1,*) T
                read(1,*) P  ! bar
            END IF
            First_Flash = .FALSE.
                        
                v=1.0
            CASE ('TV')
                read(1,*) T
                read(1,*) v  ! L/mol
                P=1.0
            CASE ('isoV')
                read(1,*) v, Ts, Ps  ! L/mol, K, bar
                read(1,*) T, dT, Tinf  ! K
                P=1.0
        END SELECT
        read(1,*) nmodel, iVshift    ! iVshift added June 2016
      if(nmodel<3)then
        call read2PcubicNC(N,1,2)
      else if(nmodel==3)then
        call readRKPRNC(N,1,2)
      end if
      READ(1,*) (Ttp(j),j=1,N)
      READ(1,*) (Ptp(j),j=1,N)
      READ(1,*) (Vs_Vl(j),j=1,N)
      READ(1,*) (C1(j),j=1,N)
      READ(1,*) (C2(j),j=1,N)
      READ(1,*) (C3(j),j=1,N)
      READ(1,*) (rNC(j),j=1,N)
      WRITE (2,*)
      write (2,4) (z(i),i=1,n)
 4	FORMAT('Molar fractions: ',20F7.4)
      WRITE (2,*)
      WRITE (3,*) '   T(K)   rho(mol/L)   P(bar)    v(L/mol)     beta       betav      iter'
      WRITE (7,*) '  T(K)   P(bar)    x1 ... xN     y1 ... yN'
      direct = .TRUE.
        SELECT CASE (spec)
            CASE ('TP')
                WRITE (2,*) ' T(K)=',T
                WRITE (2,*) ' P(bar)=',P
            CASE ('TV')
                WRITE (2,*) ' T(K)=',T
                WRITE (2,*) ' v(L/mol)=',v
                if(iVshift==1) v = v + sum(z*Vs)
            CASE ('isoV')
                WRITE (2,*) ' v(L/mol)=',v,' Ts(K)=',Ts,' Ps(bar)=',Ps  
                WRITE (2,*) ' T(K)=',T
                WRITE (3,3) Ts, 1/v, Ps, v, 1.0, 1.0
                if(iVshift==1) v = v + sum(z*Vs)
                write (*,*) 'Press 1 for direct Tv flashes'
                write (*,*) ' or 2 for indirect Tv flashes (loop of TPs)'
                read (5,*) idir
                if( idir/= 1) direct = .FALSE.
        END SELECT
! Passing values from commons(nco) to input arguments (n)
        TCn = tc(:n)
        PCn = pc(:n)
        OMGn= omg(:n)
        acn = ac(:n)
        bn = b(:n)
        delta1n = delta1(:n)
        k_or_mn = rk_or_m(:n)
        Kij_or_K0n = Kij_or_K0(:n, :n)
        Tstarn = Tstar(:n, :n)
        lijn = lij(:n, :n)
        Ttpn = Ttp(:n)
        Ptpn = Ptp(:n)
        Vs_Vln = Vs_Vl(:n)
        C1n = C1(:n)
        C2n = C2(:n)
        C3n = C3(:n)
        rNCn = rNC(:n)
        FIRST = .TRUE.

        CALL CPU_TIME(ITIME1)

        do while(P>-20.and.v>0.and.T>0)
        
        if(direct)then
            do while (T > 100.0d0)
            T = T - 1.0d0    
            call flash(spec, FIRST, nmodel, n, z, tcn, pcn, omgn, acn, bn, k_or_mn, delta1n, &
                     Kij_or_K0n, Tstarn, Lijn, t, p, v, x, y, rho_x, rho_y, beta, iter)
            end do
        
        else 
!   Block for comparison with indirect T-v Flash (Michelsen recommendation of a loop of T-P flashes)
!            CALL CPU_TIME(ITIME3)
            call zTVTERMO(n,0,T,z,V,P,DPV,PHILOG,PHILOG,PHILOG,FUGN)
            call flash('TP  ', FIRST, nmodel, n, z, tcn, pcn, omgn, acn, bn, k_or_mn, delta1n, &
                     Kij_or_K0n, Tstarn, Lijn, t, p, vcal, x, y, rho_x, rho_y, beta, iter)
            vcold = vcal
            pold = p
            p = pold*vcold/v
            call flash('TP  ', FIRST, nmodel, n, z, tcn, pcn, omgn, acn, bn, k_or_mn, delta1n, &
                     Kij_or_K0n, Tstarn, Lijn, t, p, vcal, x, y, rho_x, rho_y, beta, iter)
            RelErrv = abs(vcal-v)/v
            do while (RelErrv > 0.0001)
                slope = (p-pold)/(vcal-vcold)
                vcold = vcal
                pold = p
                p = p + (v-vcal) * slope
                
                call flash('TP  ', FIRST, nmodel, n, z, tcn, pcn, omgn, acn, bn, k_or_mn, delta1n, &
                     Kij_or_K0n, Tstarn, Lijn, t, p, vcal, x, y, rho_x, rho_y, beta, iter)
                RelErrv = abs(vcal-v)/v
            end do
!            CALL CPU_TIME(ITIME4)
!   End of block for comparison with indirect T-v Flash
        end if
!        timeind = ITIME4-ITIME3
!        PRINT *,'CPU TIME IN SEC:',timeind
        
        if(iVshift==1)then
            VsV = sum(y*Vs)
            VsL = sum(x*Vs)
            rho_y = 1 / (1/rho_y-VsV)
            rho_x = 1 / (1/rho_x-VsL)
        end if
        SELECT CASE (spec)
            CASE ('TP')
                V = beta/rho_y + (1-beta)/rho_x
                WRITE (2,*) ' v(L/mol)=',v
            CASE ('TV','isoV')
                WRITE (2,*) ' P(bar)=',P
        END SELECT
          WRITE (2,*) 'Beta (vapor phase mol fraction)= ',beta
          WRITE (2,*) 'Comp',(i,i=1,N)
          WRITE (2,1) (x(j),j=1,N)
          WRITE (2,2) (y(j),j=1,N)
          WRITE (2,*) 'liquid density (moles/L)= ',rho_x
          WRITE (2,*) 'vapour density (moles/L)= ',rho_y
          betav = beta / (V * rho_y)
          WRITE (2,*) 'BetaVol (vapor phase volume fraction)= ',betav ! output sólo para humanos
          WRITE (2,*)
          !Xplus = sum(x(Nplus:N))
          !Yplus = sum(y(Nplus:N))
          WRITE (3,3) T, 1/v, P, v, beta, betav,iter ! ,time,timeind
          WRITE (7,7) T, P, x(1:N), y(1:N)
          print *, betav 
          print *, P 
          print *, v 
 	      !print *, xplus
     	  !print *, yplus ! Este es el último print que "lee" tanto Fluids como Sur
          SELECT CASE (spec)
            CASE ('TP')
                read(1,*) P  ! bar
                WRITE (2,*) ' P(bar)=',P
            CASE ('TV')
                read(1,*) v  ! L/mol
                WRITE (2,*) ' v(L/mol)=',v
            CASE ('isoV')
                WRITE (4,*) ' v(L/mol)=',v
                WRITE (4,*) '    T(K)       Po(bar)      Pcalc(bar)'  
!                T = T - dT
                T = T + dT
                if (T < Tinf .or. T > Ts) T=0.0d0
                WRITE (2,*) ' T(K)=',T
!                CALL CPU_TIME(ITIME1)
          END SELECT
        end do  
        CALL CPU_TIME(ITIME2)
        time = ITIME2-ITIME1
        PRINT *,'CPU TIME IN SEC:',time
        WRITE (3,*) ' Time: ', time

    SELECT CASE (spec)
        CASE ('isoV')
          P = 0.0
          WRITE (3,*) ' Monophasic Region: '
          WRITE (3,*) '   T(K)   rho(mol/L)   P(bar)    v(L/mol) '
          WRITE (3,3) Ts, 1/v, Ps, v
          T = Ts
          do while (T<1000.and.P<1000)
            T = T + dT
            call zTVTERMO(n,0,T,z,V,P,DPV,PHILOG,PHILOG,PHILOG,FUGN)
            WRITE (3,3) T, 1/v, P, v
          end do
    END SELECT
 1	FORMAT('  x  ', 30E12.4)
 2	FORMAT('  y  ', 30E12.4)
 3	FORMAT(50G)
 7	FORMAT(2F8.2,60E12.4)
 end subroutine readcase


        !COMPILER-GENERATED INTERFACE MODULE: Tue Jun 25 15:18:41 2024
        MODULE FLASH__genmod
          INTERFACE 
            SUBROUTINE FLASH(SPEC,FIRST,MODEL,N,Z,TCN,PCN,OMGN,ACN,BN,  &
     &K_OR_MN,DELTA1N,KIJ_OR_K0N,TSTARN,LIJN,T,P,V,X,Y,RHO_X,RHO_Y,BETA,&
     &ITER)
              INTEGER(KIND=4), INTENT(IN) :: N
              CHARACTER(LEN=4), INTENT(IN) :: SPEC
              LOGICAL(KIND=4) :: FIRST
              INTEGER(KIND=4), INTENT(IN) :: MODEL
              REAL(KIND=8), INTENT(IN) :: Z(N)
              REAL(KIND=8), INTENT(IN) :: TCN(N)
              REAL(KIND=8), INTENT(IN) :: PCN(N)
              REAL(KIND=8), INTENT(IN) :: OMGN(N)
              REAL(KIND=8), INTENT(IN) :: ACN(N)
              REAL(KIND=8), INTENT(IN) :: BN(N)
              REAL(KIND=8), INTENT(IN) :: K_OR_MN(N)
              REAL(KIND=8), INTENT(IN) :: DELTA1N(N)
              REAL(KIND=8), INTENT(IN) :: KIJ_OR_K0N(N,N)
              REAL(KIND=8), INTENT(IN) :: TSTARN(N,N)
              REAL(KIND=8), INTENT(IN) :: LIJN(N,N)
              REAL(KIND=8), INTENT(IN) :: T
              REAL(KIND=8) :: P
              REAL(KIND=8) :: V
              REAL(KIND=8), INTENT(OUT) :: X(N)
              REAL(KIND=8), INTENT(OUT) :: Y(N)
              REAL(KIND=8), INTENT(OUT) :: RHO_X
              REAL(KIND=8), INTENT(OUT) :: RHO_Y
              REAL(KIND=8), INTENT(OUT) :: BETA
              INTEGER(KIND=4), INTENT(OUT) :: ITER
            END SUBROUTINE FLASH
          END INTERFACE 
        END MODULE FLASH__genmod

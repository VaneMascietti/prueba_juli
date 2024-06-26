        !COMPILER-GENERATED INTERFACE MODULE: Tue Jun 25 15:18:41 2024
        MODULE BETALIMITS__genmod
          INTERFACE 
            SUBROUTINE BETALIMITS(N,Z,KFACT,BMIN,BMAX)
              INTEGER(KIND=4), INTENT(IN) :: N
              REAL(KIND=8), INTENT(IN) :: Z(N)
              REAL(KIND=8), INTENT(IN) :: KFACT(N)
              REAL(KIND=8), INTENT(OUT) :: BMIN
              REAL(KIND=8), INTENT(OUT) :: BMAX
            END SUBROUTINE BETALIMITS
          END INTERFACE 
        END MODULE BETALIMITS__genmod

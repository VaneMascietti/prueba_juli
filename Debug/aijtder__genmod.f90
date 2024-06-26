        !COMPILER-GENERATED INTERFACE MODULE: Fri Mar 15 12:28:43 2024
        MODULE AIJTDER__genmod
          INTERFACE 
            SUBROUTINE AIJTDER(NTD,NC,T,AIJ,DAIJDT,DAIJDT2)
              INTEGER(KIND=4) :: NC
              INTEGER(KIND=4) :: NTD
              REAL(KIND=8) :: T
              REAL(KIND=8) :: AIJ(NC,NC)
              REAL(KIND=8) :: DAIJDT(NC,NC)
              REAL(KIND=8) :: DAIJDT2(NC,NC)
            END SUBROUTINE AIJTDER
          END INTERFACE 
        END MODULE AIJTDER__genmod

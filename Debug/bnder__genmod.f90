        !COMPILER-GENERATED INTERFACE MODULE: Fri Mar 15 12:28:43 2024
        MODULE BNDER__genmod
          INTERFACE 
            SUBROUTINE BNDER(NC,RN,BMIX,DBI,DBIJ)
              INTEGER(KIND=4) :: NC
              REAL(KIND=8) :: RN(NC)
              REAL(KIND=8) :: BMIX
              REAL(KIND=8) :: DBI(NC)
              REAL(KIND=8) :: DBIJ(NC,NC)
            END SUBROUTINE BNDER
          END INTERFACE 
        END MODULE BNDER__genmod

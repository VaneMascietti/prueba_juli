        !COMPILER-GENERATED INTERFACE MODULE: Fri Mar 15 12:28:43 2024
        MODULE ARVNDER__genmod
          INTERFACE 
            SUBROUTINE ARVNDER(NC,NDER,NTD,RN,V,T,AR,ARV,ARTV,ARV2,ARN, &
     &ARVN,ARTN,ARN2)
              INTEGER(KIND=4) :: NC
              INTEGER(KIND=4) :: NDER
              INTEGER(KIND=4) :: NTD
              REAL(KIND=8) :: RN(NC)
              REAL(KIND=8) :: V
              REAL(KIND=8) :: T
              REAL(KIND=8) :: AR
              REAL(KIND=8) :: ARV
              REAL(KIND=8) :: ARTV
              REAL(KIND=8) :: ARV2
              REAL(KIND=8) :: ARN(NC)
              REAL(KIND=8) :: ARVN(NC)
              REAL(KIND=8) :: ARTN(NC)
              REAL(KIND=8) :: ARN2(NC,NC)
            END SUBROUTINE ARVNDER
          END INTERFACE 
        END MODULE ARVNDER__genmod

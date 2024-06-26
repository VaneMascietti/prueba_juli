        !COMPILER-GENERATED INTERFACE MODULE: Thu Mar 14 17:32:06 2024
        MODULE HELMSRKPR__genmod
          INTERFACE 
            SUBROUTINE HELMSRKPR(NC,ND,NT,RN,V,T,AR,ARV,ARTV,ARV2,ARN,  &
     &ARVN,ARTN,ARN2)
              INTEGER(KIND=4) :: NC
              INTEGER(KIND=4) :: ND
              INTEGER(KIND=4) :: NT
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
            END SUBROUTINE HELMSRKPR
          END INTERFACE 
        END MODULE HELMSRKPR__genmod

        !COMPILER-GENERATED INTERFACE MODULE: Fri Mar 15 12:28:43 2024
        MODULE HELMRKPR__genmod
          INTERFACE 
            SUBROUTINE HELMRKPR(NCO,NDE,NTD,RN,V,T,AR,ARV,ARTV,ARV2,ARN,&
     &ARVN,ARTN,ARN2)
              INTEGER(KIND=4) :: NCO
              INTEGER(KIND=4) :: NDE
              INTEGER(KIND=4) :: NTD
              REAL(KIND=8) :: RN(NCO)
              REAL(KIND=8) :: V
              REAL(KIND=8) :: T
              REAL(KIND=8) :: AR
              REAL(KIND=8) :: ARV
              REAL(KIND=8) :: ARTV
              REAL(KIND=8) :: ARV2
              REAL(KIND=8) :: ARN(NCO)
              REAL(KIND=8) :: ARVN(NCO)
              REAL(KIND=8) :: ARTN(NCO)
              REAL(KIND=8) :: ARN2(NCO,NCO)
            END SUBROUTINE HELMRKPR
          END INTERFACE 
        END MODULE HELMRKPR__genmod

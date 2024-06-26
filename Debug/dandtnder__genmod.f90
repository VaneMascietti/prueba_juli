        !COMPILER-GENERATED INTERFACE MODULE: Fri Mar 15 12:28:43 2024
        MODULE DANDTNDER__genmod
          INTERFACE 
            SUBROUTINE DANDTNDER(NTD,NCO,T,RN,D,DDI,DDIT,DDIJ,DDDT,DDDT2&
     &)
              INTEGER(KIND=4) :: NCO
              INTEGER(KIND=4) :: NTD
              REAL(KIND=8) :: T
              REAL(KIND=8) :: RN(NCO)
              REAL(KIND=8) :: D
              REAL(KIND=8) :: DDI(NCO)
              REAL(KIND=8) :: DDIT(NCO)
              REAL(KIND=8) :: DDIJ(NCO,NCO)
              REAL(KIND=8) :: DDDT
              REAL(KIND=8) :: DDDT2
            END SUBROUTINE DANDTNDER
          END INTERFACE 
        END MODULE DANDTNDER__genmod

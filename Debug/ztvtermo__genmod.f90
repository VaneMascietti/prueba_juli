        !COMPILER-GENERATED INTERFACE MODULE: Fri Mar 15 12:25:06 2024
        MODULE ZTVTERMO__genmod
          INTERFACE 
            SUBROUTINE ZTVTERMO(NC,INDIC,T,RN,V,P,DPV,PHILOG,DLPHIP,    &
     &DLPHIT,FUGN)
              INTEGER(KIND=4) :: NC
              INTEGER(KIND=4) :: INDIC
              REAL(KIND=8) :: T
              REAL(KIND=8) :: RN(NC)
              REAL(KIND=8) :: V
              REAL(KIND=8) :: P
              REAL(KIND=8) :: DPV
              REAL(KIND=8) ,OPTIONAL, INTENT(OUT) :: PHILOG(NC)
              REAL(KIND=8) ,OPTIONAL, INTENT(OUT) :: DLPHIP(NC)
              REAL(KIND=8) ,OPTIONAL, INTENT(OUT) :: DLPHIT(NC)
              REAL(KIND=8) ,OPTIONAL, INTENT(OUT) :: FUGN(NC,NC)
            END SUBROUTINE ZTVTERMO
          END INTERFACE 
        END MODULE ZTVTERMO__genmod

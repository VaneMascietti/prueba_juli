        !COMPILER-GENERATED INTERFACE MODULE: Fri Mar 15 12:21:40 2024
        MODULE TERMO__genmod
          INTERFACE 
            SUBROUTINE TERMO(NC,MTYP,INDIC,T,P,RN,V,PHILOG,DLPHIP,DLPHIT&
     &,FUGN)
              INTEGER(KIND=4) :: NC
              INTEGER(KIND=4) :: MTYP
              INTEGER(KIND=4) :: INDIC
              REAL(KIND=8) :: T
              REAL(KIND=8) :: P
              REAL(KIND=8) :: RN(NC)
              REAL(KIND=8) :: V
              REAL(KIND=8) ,OPTIONAL, INTENT(OUT) :: PHILOG(NC)
              REAL(KIND=8) ,OPTIONAL, INTENT(OUT) :: DLPHIP(NC)
              REAL(KIND=8) ,OPTIONAL, INTENT(OUT) :: DLPHIT(NC)
              REAL(KIND=8) ,OPTIONAL, INTENT(OUT) :: FUGN(NC,NC)
            END SUBROUTINE TERMO
          END INTERFACE 
        END MODULE TERMO__genmod

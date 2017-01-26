       IDENTIFICATION DIVISION.
       PROGRAM-ID. ART100.
      /
      ***********************
      * This program check Article critical values
      ***********************
       ENVIRONMENT DIVISION.
      ***********************
      *
       CONFIGURATION SECTION.
      ***********************
      *
       SOURCE-COMPUTER. IBM-AS400.
       OBJECT-COMPUTER. IBM-AS400.
       COPY WSPECNAMES.
      *
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT  ARTICLE
                   ASSIGN       TO DATABASE-ARTICLE1
                   ORGANIZATION IS INDEXED
                   ACCESS       IS DYNAMIC
                   RECORD KEY   IS EXTERNALLY-DESCRIBED-KEY
                   FILE STATUS  IS ST.
      *
           SELECT  ARTINFO
                   ASSIGN       TO DATABASE-ARTIINF
                   ORGANIZATION IS INDEXED
                   ACCESS       IS DYNAMIC
                   RECORD KEY   IS EXTERNALLY-DESCRIBED-KEY
                   WITH DUPLICATES
                   FILE STATUS  IS ST.
      *
           SELECT  ARTIPROV
                   ASSIGN       TO DATABASE-ARTIPROV
                   ORGANIZATION IS INDEXED
                   ACCESS       IS DYNAMIC
                   RECORD KEY   IS EXTERNALLY-DESCRIBED-KEY
                   FILE STATUS  IS ST.
      *
           SELECT  DETORD
                   ASSIGN       TO DATABASE-DETORD
                   ACCESS       IS SEQUENTIAL
                   FILE STATUS  IS ST.
      *
      /
       DATA    DIVISION.
       FILE    SECTION.
      *
       FD  ARTICLE   LABEL RECORD STANDARD.
       01  ART-ENR-DDS.
           COPY DDS-ALL-FORMAT OF ARTICLE1.
      *
       FD  ARTINFO   LABEL RECORD STANDARD.
       01  INFO-ENR-DDS.
           COPY DDS-ALL-FORMAT OF ARTIINF.
      *
       FD  ARTIPROV   LABEL RECORD STANDARD.
       01  PROV-ENR-DDS.
           COPY DDS-ALL-FORMAT OF ARTIPROV.
      *
       FD  DETORD  LABEL RECORD STANDARD.
       01  DET-ENR-DDS.
           COPY DDS-ALL-FORMAT OF DETORD.
      *
      /
       WORKING-STORAGE SECTION.
       77  CPT-LUS           PIC 9(6) VALUE ZERO.
       77  CPT-ECR           PIC 9(6) VALUE ZERO.
       77  CPT-ANO           PIC 9(6) VALUE ZERO.
       77  DR-QT                  PIC S9(8)V9(3) COMP-3.
       77  DR-PR                  PIC S9(6)V9(3) COMP-3.
       77  TOP-ENTERR        PIC 1    VALUE B"0".
      *
       77  ST                     PIC XX.
       77  WS-END                 PIC XX.
       77  WS-ERR                 PIC XX.
       77  WS-LIBERR              PIC X(35).
      *
       01  DATE-JOUR   VALUE SPACES.
           05  AN          PIC XX.
           05  MOI         PIC XX.
           05  JOUR        PIC XX.
      *
       01  HEURE-JOUR  VALUE SPACES.
           05  HH          PIC XX.
           05  MN          PIC XX.
           05  SS          PIC XX.
           05  CC          PIC XX.
      *
      /
      *
      ********************
       PROCEDURE DIVISION.
      ********************
       INIT SECTION.
      ********************
       DEBUT-PROG.
      ***** MESSAGE DE DEBUT
           ACCEPT   DATE-JOUR  FROM  DATE.
           ACCEPT   HEURE-JOUR FROM  TIME.
      *
           OPEN INPUT  DETORD.
      *
           OPEN INPUT  ARTICLE
                       ARTINFO
                       ARTIPROV.
      *
           MOVE "00" TO WS-END.
      *
           READ DETORD  NEXT AT END
                        MOVE HIGH-VALUE TO WS-END
                        GO  TO   VIDE.
      *
           PERFORM TRAITEMENT-DETAIL.
      *
       VIDE.
      *
           CLOSE  ARTICLE
                  ARTINFO
                  ARTIPROV
                  DETORD.
      *
           STOP    RUN.
      ***********************************************************
      ***  END PROGRAM
      ***********************************************************
      /
       TRAITEMENT-DETAIL SECTION.
      ***************************
      /
       TRT-RECORD.
           IF WS-END = "00" THEN
      *
           PERFORM WORKS-LINES.
      *
       READ-NEXT.
           READ DETORD  NEXT AT END
                        MOVE HIGH-VALUE TO WS-END
                        GO  TO   END-RECORD.
      *
       END-RECORD.
           EXIT.
      /
      ****************************************************************
      ******* SOUS-ROUTINE INITIALISATION DE BPFER
      ****************************************************************
      /
       WORKS-LINES SECTION.
      ***************************
      /
       TRT-RECORD.
      *
           MOVE ORDDAR TO  ARTIID OF ART-ENR-DDS
           READ ARTICLE INVALID KEY MOVE "88"  TO  WS-ERR
                                  MOVE "ARTICLE NOT FOUND" TO WS-LIBERR
                                  GO  TO     END-RECORD.
      *
           MOVE ORDDAR TO  ARTIID OF INFO-ENR-DDS
           READ ARTINFO INVALID KEY MOVE "99"  TO  WS-ERR
                                  MOVE "INFOS NOT FOUND" TO WS-LIBERR
                                  GO  TO     END-RECORD.
      *
           MOVE ORDDAR TO  ARTIID OF PROV-ENR-DDS
           READ ARTIPROV NEXT AT END MOVE "77"  TO  WS-ERR
                             MOVE "PROVIDER NOT FOUND" TO WS-LIBERR
                                   GO  TO     END-RECORD.
           IF ARTIID OF PROV-ENR-DDS NOT = ORDDAR
           THEN MOVE "77" TO WS-ERR.
      *
       END-RECORD.
           EXIT.
      /
 

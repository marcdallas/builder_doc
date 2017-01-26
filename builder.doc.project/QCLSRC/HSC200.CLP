/********************************************************************/
/* Program     : HSC200                                             */
/* Purpose     : Sales Order Processing.                            */
/* System      : HSV - Voucher Tracking and Control                 */
/* Date        : February 1999                                      */
/********************************************************************/
/* MMo change 1 */

             PGM        PARM(&MODE &ORDER &TYPE &CUST)
             DCL        VAR(&MODE) TYPE(*CHAR) LEN(1)
             DCL        VAR(&ORDER) TYPE(*CHAR) LEN(8)
             DCL        VAR(&CUST) TYPE(*CHAR) LEN(3)
             DCL        VAR(&TYPE) TYPE(*CHAR) LEN(8)
             OVRDBF     FILE(ALTCUSTA) TOFILE(HSLCUSTA)
             CALL       PGM(HSR200) PARM(&MODE &ORDER &TYPE &CUST)
             DLTOVR     FILE(ALTCUSTA)

             ENDPGM

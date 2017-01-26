/********************************************************************/
/*                                                                  */
/* 5769SS1 V4R4M0 990521     Sortie RTVCLSRC     16/02/00 16:19:54  */
/*                                                                  */
/*                                                             MMOED*/
/********************************************************************/
     PGM
     OVRDBF FILE(HSLINVTA) SHARE(*YES)
             OVRDBF     FILE(HSLCUSTA) TOFILE(*LIBL/HSLCUSTAB) +
                          MBR(*FIRST) SHARE(*YES)
     CALL PGM(HSR701)
     CPYFRMQRYF FROMOPNID(HSLINVTA) TOFILE(*PRINT)
     CALL       PGM(HSR701)
     RETURN
     ENDPGM

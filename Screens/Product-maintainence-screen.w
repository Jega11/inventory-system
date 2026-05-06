&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
          retaildb         PROGRESS
*/
&Scoped-define WINDOW-NAME wWin
{adecomm/appserv.i}
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wWin 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: New V9 Version - January 15, 1998
          
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AB.              */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

{src/adm2/widgetprto.i}
DEFINE BUFFER buff-ProductMaster FOR ProductMaster.
DEFINE TEMP-TABLE temp-productmaster NO-UNDO
  FIELD category LIKE ProductMaster.category
  FIELD price LIKE ProductMaster.price
  FIELD productid LIKE ProductMaster.productid
  FIELD productname LIKE ProductMaster.productname
  FIELD stockquantity LIKE ProductMaster.stockquantity.

DEFINE VARIABLE next-product-id AS INTEGER NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

&Scoped-define ADM-SUPPORTED-LINKS Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fMain
&Scoped-define BROWSE-NAME BROWSE-13

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES ProductMaster

/* Definitions for BROWSE BROWSE-13                                     */
&Scoped-define FIELDS-IN-QUERY-BROWSE-13 ProductMaster.category ~
ProductMaster.price ProductMaster.productid ProductMaster.productname ~
ProductMaster.stockquantity 
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-13 
&Scoped-define QUERY-STRING-BROWSE-13 FOR EACH ProductMaster NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-BROWSE-13 OPEN QUERY BROWSE-13 FOR EACH ProductMaster NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-BROWSE-13 ProductMaster
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-13 ProductMaster


/* Definitions for FRAME fMain                                          */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fMain ~
    ~{&OPEN-QUERY-BROWSE-13}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BROWSE-13 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-CANCEL 
     LABEL "CANCEL" 
     SIZE 17 BY 1.38.

DEFINE BUTTON BUTTON-RESET 
     LABEL "RESET" 
     SIZE 17 BY 1.38.

DEFINE BUTTON BUTTON_ADD 
     LABEL "ADD" 
     SIZE 17 BY 1.38.

DEFINE BUTTON BUTTON_CLOSE 
     LABEL "CLOSE" 
     SIZE 17 BY 1.38.

DEFINE BUTTON BUTTON_DELETE 
     LABEL "DELETE" 
     SIZE 17 BY 1.38.

DEFINE BUTTON BUTTON_SAVE 
     LABEL "SAVE" 
     SIZE 17 BY 1.38.

DEFINE BUTTON BUTTON_UPDATE 
     LABEL "UPDATE" 
     SIZE 17 BY 1.38.

DEFINE VARIABLE CAT_FILL AS CHARACTER FORMAT "X(256)":U 
     LABEL "category" 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE PRICE_FILL AS CHARACTER FORMAT "X(256)":U 
     LABEL "price" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE PROID_FILL AS CHARACTER FORMAT "X(256)":U 
     LABEL "Product ID" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE PRONM_FILL AS CHARACTER FORMAT "X(256)":U 
     LABEL "product name" 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1 NO-UNDO.

DEFINE VARIABLE STO_FILL AS CHARACTER FORMAT "X(256)":U 
     LABEL "stock quantity" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-13 FOR 
      ProductMaster SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-13 wWin _STRUCTURED
  QUERY BROWSE-13 NO-LOCK DISPLAY
      ProductMaster.category FORMAT "x(30)":U
      ProductMaster.price FORMAT ">>>9":U WIDTH 30.4
      ProductMaster.productid FORMAT ">>>>9":U WIDTH 23.2
      ProductMaster.productname FORMAT "x(30)":U WIDTH 37.2
      ProductMaster.stockquantity FORMAT ">>>9":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 178 BY 11.67
         BGCOLOR 14  ROW-HEIGHT-CHARS .76 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     BROWSE-13 AT ROW 1 COL 2 WIDGET-ID 500
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 179.2 BY 26 WIDGET-ID 100.

DEFINE FRAME FRAME-F
     BUTTON_ADD AT ROW 1.95 COL 5 WIDGET-ID 14
     BUTTON_UPDATE AT ROW 1.95 COL 29 WIDGET-ID 4
     BUTTON_SAVE AT ROW 1.95 COL 52 WIDGET-ID 10
     BUTTON_DELETE AT ROW 1.95 COL 76 WIDGET-ID 8
     BUTTON-RESET AT ROW 1.95 COL 101 WIDGET-ID 18
     BUTTON-CANCEL AT ROW 1.95 COL 126 WIDGET-ID 20
     BUTTON_CLOSE AT ROW 1.95 COL 150 WIDGET-ID 12
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 12.67
         SIZE 178 BY 4.29
         TITLE "" WIDGET-ID 300.

DEFINE FRAME FRAME-G
     CAT_FILL AT ROW 1.95 COL 15 COLON-ALIGNED WIDGET-ID 2
     PROID_FILL AT ROW 1.95 COL 55 COLON-ALIGNED WIDGET-ID 6
     PRONM_FILL AT ROW 1.95 COL 100 COLON-ALIGNED WIDGET-ID 10
     PRICE_FILL AT ROW 4.81 COL 15 COLON-ALIGNED WIDGET-ID 4
     STO_FILL AT ROW 4.81 COL 55 COLON-ALIGNED WIDGET-ID 8
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2 ROW 16.95
         SIZE 178 BY 10
         TITLE "" WIDGET-ID 400.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Container Links: Data-Target,Data-Source,Page-Target,Update-Source,Update-Target,Filter-target,Filter-Source
   Other Settings: APPSERVER
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wWin ASSIGN
         HIDDEN             = YES
         TITLE              = "Product maintenance screen"
         HEIGHT             = 26.29
         WIDTH              = 180
         MAX-HEIGHT         = 30.91
         MAX-WIDTH          = 256
         VIRTUAL-HEIGHT     = 30.91
         VIRTUAL-WIDTH      = 256
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB wWin 
/* ************************* Included-Libraries *********************** */

{src/adm2/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wWin
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME FRAME-F:FRAME = FRAME fMain:HANDLE
       FRAME FRAME-G:FRAME = FRAME fMain:HANDLE.

/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME FRAME-F:MOVE-AFTER-TAB-ITEM (BROWSE-13:HANDLE IN FRAME fMain)
       XXTABVALXX = FRAME FRAME-F:MOVE-BEFORE-TAB-ITEM (FRAME FRAME-G:HANDLE)
/* END-ASSIGN-TABS */.

/* BROWSE-TAB BROWSE-13 1 fMain */
/* SETTINGS FOR FRAME FRAME-F
                                                                        */
/* SETTINGS FOR FRAME FRAME-G
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-13
/* Query rebuild information for BROWSE BROWSE-13
     _TblList          = "retaildb.ProductMaster"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = retaildb.ProductMaster.category
     _FldNameList[2]   > retaildb.ProductMaster.price
"ProductMaster.price" ? ? "integer" ? ? ? ? ? ? no ? no no "30.4" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > retaildb.ProductMaster.productid
"ProductMaster.productid" ? ? "integer" ? ? ? ? ? ? no ? no no "23.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > retaildb.ProductMaster.productname
"ProductMaster.productname" ? ? "character" ? ? ? ? ? ? no ? no no "37.2" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   = retaildb.ProductMaster.stockquantity
     _Query            is OPENED
*/  /* BROWSE BROWSE-13 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Product maintenance screen */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Product maintenance screen */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-13
&Scoped-define SELF-NAME BROWSE-13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BROWSE-13 wWin
ON VALUE-CHANGED OF BROWSE-13 IN FRAME fMain
DO:
  RUN setfillins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-F
&Scoped-define SELF-NAME BUTTON-CANCEL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-CANCEL wWin
ON CHOOSE OF BUTTON-CANCEL IN FRAME FRAME-F /* CANCEL */
DO:
  RUN initialstage.
  RUN disablefillins.
  RUN setfillins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-RESET
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-RESET wWin
ON CHOOSE OF BUTTON-RESET IN FRAME FRAME-F /* RESET */
DO:
 RUN resetfillins.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON_ADD
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON_ADD wWin
ON CHOOSE OF BUTTON_ADD IN FRAME FRAME-F /* ADD */
DO:
  RUN ADD-BUTTON.
  RUN enablefillins.
  DO WITH FRAME fMain:
    BROWSE-13:DESELECT-ROWS().
  END.
RUN resetfillins.

  FIND LAST ProductMaster NO-LOCK NO-ERROR.      
  IF AVAILABLE ProductMaster THEN
    next-product-id = ProductMaster.productid + 1.
  ELSE
    next-product-id = 1.
  DO WITH FRAME FRAME-G:
    PROID_FILL:SCREEN-VALUE = STRING(next-product-id).
    PROID_FILL:SENSITIVE = FALSE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON_CLOSE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON_CLOSE wWin
ON CHOOSE OF BUTTON_CLOSE IN FRAME FRAME-F /* CLOSE */
CURRENT-WINDOW:HIDDEN = TRUE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON_DELETE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON_DELETE wWin
ON CHOOSE OF BUTTON_DELETE IN FRAME FRAME-F /* DELETE */
DO:
  RUN DELETE-BUTTON.
  RUN refreshh.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON_SAVE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON_SAVE wWin
ON CHOOSE OF BUTTON_SAVE IN FRAME FRAME-F /* SAVE */
DO:
  RUN SAVE-OR-UPDATE-RECORD.
  RUN refreshh.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON_UPDATE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON_UPDATE wWin
ON CHOOSE OF BUTTON_UPDATE IN FRAME FRAME-F /* UPDATE */
DO:
  DO WITH FRAME FRAME-F:
  RUN UPDATE-BUTTON.
  RUN update-time-fillin.
  END.
  DO WITH FRAME fMain:
  BROWSE-13:DESELECT-ROWS().
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fMain
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wWin 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
//{src/adm2/windowmn.i}

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.
 
/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.
 
/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.
 
/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  RUN setfillins.
  RUN initialstage.
  RUN disablefillins.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ADD-BUTTON wWin 
PROCEDURE ADD-BUTTON :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
     DO WITH FRAME FRAME-F:
      ASSIGN
        BUTTON_ADD:SENSITIVE = FALSE
        BUTTON_UPDATE:SENSITIVE = FALSE
        BUTTON_DELETE:SENSITIVE = FALSE
        BUTTON_CLOSE:SENSITIVE = TRUE
        BUTTON_SAVE:SENSITIVE = TRUE
        BUTTON-RESET:SENSITIVE = TRUE.
   END.
   DO WITH FRAME FRAME-G:
   ASSIGN
      CAT_FILL:SCREEN-VALUE = ""
      PRICE_FILL:SCREEN-VALUE= ""
      STO_FILL:SCREEN-VALUE = ""
      PRONM_FILL:SCREEN-VALUE = "".
      END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects wWin  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DELETE-BUTTON wWin 
PROCEDURE DELETE-BUTTON :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME fmain:
    FIND CURRENT ProductMaster EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE ProductMaster THEN DO:
        MESSAGE "Are you sure you want to DELETE this record?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        UPDATE choice AS LOGICAL.
        IF choice THEN DO:
            DELETE ProductMaster.
        END.
        ELSE DO:
            MESSAGE "No record is deleted" VIEW-AS ALERT-BOX INFO.
        END.
    END.
    ELSE DO:
        MESSAGE "Cannot find the record to delete." VIEW-AS ALERT-BOX WARNING.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disablefillins wWin 
PROCEDURE disablefillins :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 DO WITH FRAME FRAME-G:
 ASSIGN
    CAT_FILL:SENSITIVE = FALSE
    PRICE_FILL:SENSITIVE = FALSE
    PROID_FILL:SENSITIVE = FALSE
    STO_FILL:SENSITIVE = FALSE
    PRONM_FILL:SENSITIVE = FALSE.
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wWin  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
  THEN DELETE WIDGET wWin.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enablefillins wWin 
PROCEDURE enablefillins :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 DO WITH FRAME FRAME-G:
  ASSIGN
    CAT_FILL:SENSITIVE = TRUE
    PRICE_FILL:SENSITIVE = TRUE
    PROID_FILL:SENSITIVE = FALSE 
    STO_FILL:SENSITIVE = TRUE
    PRONM_FILL:SENSITIVE = TRUE.
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wWin  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  ENABLE BROWSE-13 
      WITH FRAME fMain IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
  ENABLE BUTTON_ADD BUTTON_UPDATE BUTTON_SAVE BUTTON_DELETE BUTTON-RESET 
         BUTTON-CANCEL BUTTON_CLOSE 
      WITH FRAME FRAME-F IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-F}
  DISPLAY CAT_FILL PROID_FILL PRONM_FILL PRICE_FILL STO_FILL 
      WITH FRAME FRAME-G IN WINDOW wWin.
  ENABLE CAT_FILL PROID_FILL PRONM_FILL PRICE_FILL STO_FILL 
      WITH FRAME FRAME-G IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-G}
  VIEW wWin.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE exitObject wWin 
PROCEDURE exitObject :
/*------------------------------------------------------------------------------
  Purpose:  Window-specific override of this procedure which destroys 
            its contents and itself.
    Notes:  
------------------------------------------------------------------------------*/

  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initialstage wWin 
PROCEDURE initialstage :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   DO WITH FRAME FRAME-F:
   ASSIGN
        BUTTON_ADD:SENSITIVE = TRUE
        BUTTON_UPDATE:SENSITIVE = TRUE
        BUTTON_DELETE:SENSITIVE = TRUE
        BUTTON_CLOSE:SENSITIVE = TRUE
        BUTTON_SAVE:SENSITIVE = FALSE
        BUTTON-RESET:SENSITIVE = FALSE.
   END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE loadtemptable wWin 
PROCEDURE loadtemptable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-G:
      CREATE temp-productmaster.
      ASSIGN
      temp-productmaster.category = CAT_FILL:SCREEN-VALUE  
      temp-productmaster.price = integer(PRICE_FILL:SCREEN-VALUE)  
      temp-productmaster.productid = integer(PROID_FILL:SCREEN-VALUE) 
      temp-productmaster.productname = PRONM_FILL:SCREEN-VALUE  
      temp-productmaster.stockquantity = integer(STO_FILL:SCREEN-VALUE).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE refreshh wWin 
PROCEDURE refreshh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
{&OPEN-QUERY-BROWSE-13}
    DO WITH FRAME fMain:
        APPLY 'VALUE-CHANGED' TO Browse-13.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE resetfillins wWin 
PROCEDURE resetfillins :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-G:
    IF CAT_FILL:SENSITIVE = TRUE THEN DO WITH FRAME FRAME-G:
    ASSIGN
      CAT_FILL:SCREEN-VALUE = ""
      PRICE_FILL:SCREEN-VALUE= ""
      STO_FILL:SCREEN-VALUE = ""
      PRONM_FILL:SCREEN-VALUE = "".

    END.
    ELSE DO:
      ASSIGN
      PRICE_FILL:SCREEN-VALUE= ""
      STO_FILL:SCREEN-VALUE = "".
      END.
    END.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE SAVE-OR-UPDATE-RECORD wWin 
PROCEDURE SAVE-OR-UPDATE-RECORD :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-F:
  IF CAT_FILL:SCREEN-VALUE IN FRAME FRAME-G = "" OR PRONM_FILL:SCREEN-VALUE IN FRAME FRAME-G = "" THEN
  MESSAGE "Atlest Enter Category and product name to ADD a record" 
          VIEW-AS ALERT-BOX ERROR.
  ELSE
       DO WITH FRAME FRAME-G:
          RUN loadtemptable.
             FOR EACH temp-productmaster:
                FIND buff-ProductMaster WHERE buff-ProductMaster.productid = temp-productmaster.productid EXCLUSIVE-LOCK NO-ERROR.
                IF AVAILABLE buff-ProductMaster THEN DO:
                BUFFER-COPY temp-productmaster TO buff-ProductMaster.
                MESSAGE "Record UPDATED"VIEW-AS ALERT-BOX INFO.
                END.
                
             ELSE DO:
                    CREATE buff-ProductMaster.
                    BUFFER-COPY temp-productmaster TO buff-ProductMaster.
                    MESSAGE "Record ADDED" VIEW-AS ALERT-BOX INFO.
             END.
             END.
       END.
RUN refreshh.
RUN initialstage.
RUN disablefillins.
  END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setfillins wWin 
PROCEDURE setfillins :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  DO WITH FRAME FRAME-G:
     FIND CURRENT ProductMaster NO-LOCK NO-ERROR.
     IF AVAILABLE ProductMaster THEN
     DO:
      ASSIGN
        CAT_FILL:SCREEN-VALUE  = ProductMaster.category 
        PRICE_FILL:SCREEN-VALUE  = string(ProductMaster.price) 
        PROID_FILL:SCREEN-VALUE  = string(ProductMaster.productid) 
        PRONM_FILL:SCREEN-VALUE  = ProductMaster.productname 
        STO_FILL:SCREEN-VALUE  = string(ProductMaster.stockquantity).
      END.
  END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE UPDATE-BUTTON wWin 
PROCEDURE UPDATE-BUTTON :
/*------------------------------------------------------------------------------
  Purpose:     Save or update ProductMaster record from fill-ins
  Parameters:  <none>
  Notes:       Converts CHARACTER fill-ins to correct data types
------------------------------------------------------------------------------*/    
   DO WITH FRAME FRAME-F:
   ASSIGN
   BUTTON_ADD:SENSITIVE = FALSE
   BUTTON_UPDATE:SENSITIVE = FALSE
   BUTTON_SAVE:SENSITIVE = TRUE
   BUTTON_CLOSE:SENSITIVE = TRUE
   BUTTON_DELETE:SENSITIVE = FALSE
   BUTTON-RESET:SENSITIVE = TRUE.
   END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE update-time-fillin wWin 
PROCEDURE update-time-fillin :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 DO WITH FRAME FRAME-G:
  ASSIGN 
    CAT_FILL:SENSITIVE = FALSE
    PRICE_FILL:SENSITIVE = TRUE
    PROID_FILL:SENSITIVE = FALSE
    STO_FILL:SENSITIVE = TRUE
    PRONM_FILL:SENSITIVE = FALSE.
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


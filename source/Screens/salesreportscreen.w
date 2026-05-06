&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
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
DEFINE TEMP-TABLE temp-date-prodt-report NO-UNDO
    FIELD productid AS INTEGER
    FIELD productname AS CHARACTER                                  
    FIELD transactiondate AS DATE
    FIELD quantitysold AS INTEGER
    FIELD totalprice AS DECIMAL.   
   
DEFINE TEMP-TABLE temp-totalrev NO-UNDO
    FIELD productid AS INTEGER
    FIELD productname AS CHARACTER                                  
    FIELD quantitysold AS INTEGER
    FIELD totalprice AS DECIMAL.
    
DEFINE TEMP-TABLE temp-inventory NO-UNDO
    FIELD productid AS INTEGER
    FIELD productname AS CHARACTER                                  
    FIELD stockquantity AS INTEGER
    FIELD price AS DECIMAL
    FIELD category AS CHARACTER.
    
DEFINE VARIABLE strdate AS DATE NO-UNDO.
DEFINE VARIABLE endate AS DATE NO-UNDO.
    
DEFINE VARIABLE rdate AS DATE  NO-UNDO.
DEFINE VARIABLE fname AS CHARACTER NO-UNDO.
DEFINE VARIABLE ftime AS CHARACTER NO-UNDO.
DEFINE VARIABLE dname AS CHARACTER NO-UNDO.

DEFINE stream s1.

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
&Scoped-define BROWSE-NAME BROWSE-11

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES temp-inventory temp-date-prodt-report ~
temp-totalrev

/* Definitions for BROWSE BROWSE-11                                     */
&Scoped-define FIELDS-IN-QUERY-BROWSE-11 temp-inventory.productid temp-inventory.productname temp-inventory.stockquantity temp-inventory.category temp-inventory.price   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-11   
&Scoped-define SELF-NAME BROWSE-11
&Scoped-define QUERY-STRING-BROWSE-11 FOR EACH temp-inventory
&Scoped-define OPEN-QUERY-BROWSE-11 OPEN QUERY {&SELF-NAME} FOR EACH temp-inventory.
&Scoped-define TABLES-IN-QUERY-BROWSE-11 temp-inventory
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-11 temp-inventory


/* Definitions for BROWSE BROWSE-7                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-7 temp-date-prodt-report.productid temp-date-prodt-report.productname temp-date-prodt-report.transactiondate temp-date-prodt-report.quantitysold temp-date-prodt-report.totalprice   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-7   
&Scoped-define SELF-NAME BROWSE-7
&Scoped-define QUERY-STRING-BROWSE-7 FOR EACH temp-date-prodt-report
&Scoped-define OPEN-QUERY-BROWSE-7 OPEN QUERY {&SELF-NAME} FOR EACH temp-date-prodt-report.
&Scoped-define TABLES-IN-QUERY-BROWSE-7 temp-date-prodt-report
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-7 temp-date-prodt-report


/* Definitions for BROWSE BROWSE-9                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-9 temp-totalrev.productid temp-totalrev.productname temp-totalrev.quantitysold temp-totalrev.totalprice   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-9   
&Scoped-define SELF-NAME BROWSE-9
&Scoped-define QUERY-STRING-BROWSE-9 FOR EACH temp-totalrev
&Scoped-define OPEN-QUERY-BROWSE-9 OPEN QUERY {&SELF-NAME} FOR EACH temp-totalrev.
&Scoped-define TABLES-IN-QUERY-BROWSE-9 temp-totalrev
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-9 temp-totalrev


/* Definitions for FRAME FRAME-A                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-FRAME-A ~
    ~{&OPEN-QUERY-BROWSE-11}~
    ~{&OPEN-QUERY-BROWSE-7}~
    ~{&OPEN-QUERY-BROWSE-9}

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-1 
     LABEL "EXIT" 
     SIZE 20 BY 1.52.

DEFINE BUTTON BUTTON-2 
     LABEL "EXPORT" 
     SIZE 20 BY 1.52.

DEFINE BUTTON BUTTON-3 
     LABEL "SUBMIT" 
     SIZE 20 BY 1.52.

DEFINE VARIABLE COMBO-BOX-2 AS CHARACTER FORMAT "X(256)":U 
     LABEL "Report Type" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Sales by Date","Sales by Product","Total Revenue Report","Inventory Details" 
     DROP-DOWN-LIST
     SIZE 30 BY 1 NO-UNDO.

DEFINE VARIABLE ENDATE-FILL AS DATE FORMAT "99/99/99":U 
     LABEL "END DATE" 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1 NO-UNDO.

DEFINE VARIABLE STRDATE-FILL AS DATE FORMAT "99/99/99":U 
     LABEL "STRAT DATE" 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1 NO-UNDO.

DEFINE VARIABLE SELECT-3 AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SCROLLBAR-VERTICAL 
     SIZE 27 BY 4.05 NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY BROWSE-11 FOR 
      temp-inventory SCROLLING.

DEFINE QUERY BROWSE-7 FOR 
      temp-date-prodt-report SCROLLING.

DEFINE QUERY BROWSE-9 FOR 
      temp-totalrev SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-11 wWin _FREEFORM
  QUERY BROWSE-11 DISPLAY
      temp-inventory.productid
      temp-inventory.productname
      temp-inventory.stockquantity
      temp-inventory.category
      temp-inventory.price
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 167 BY 15
         BGCOLOR 14  ROW-HEIGHT-CHARS .67 FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-7 wWin _FREEFORM
  QUERY BROWSE-7 DISPLAY
      temp-date-prodt-report.productid
      temp-date-prodt-report.productname
      temp-date-prodt-report.transactiondate
      temp-date-prodt-report.quantitysold
      temp-date-prodt-report.totalprice
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 167 BY 15
         BGCOLOR 14  ROW-HEIGHT-CHARS .86 FIT-LAST-COLUMN.

DEFINE BROWSE BROWSE-9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-9 wWin _FREEFORM
  QUERY BROWSE-9 DISPLAY
      temp-totalrev.productid
      temp-totalrev.productname
      temp-totalrev.quantitysold
      temp-totalrev.totalprice
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 167 BY 15
         BGCOLOR 14  ROW-HEIGHT-CHARS .81 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 173 BY 24.1 WIDGET-ID 100.

DEFINE FRAME FRAME-A
     BUTTON-3 AT ROW 1.71 COL 69 WIDGET-ID 14
     COMBO-BOX-2 AT ROW 1.95 COL 27 COLON-ALIGNED WIDGET-ID 4
     SELECT-3 AT ROW 2.19 COL 99 NO-LABEL WIDGET-ID 22
     STRDATE-FILL AT ROW 2.19 COL 145 COLON-ALIGNED WIDGET-ID 24
     BUTTON-2 AT ROW 3.86 COL 69 WIDGET-ID 8
     ENDATE-FILL AT ROW 5.29 COL 145 COLON-ALIGNED WIDGET-ID 26
     BUTTON-1 AT ROW 6.24 COL 69 WIDGET-ID 6
     BROWSE-9 AT ROW 8.14 COL 4 WIDGET-ID 500
     BROWSE-7 AT ROW 8.14 COL 4 WIDGET-ID 400
     BROWSE-11 AT ROW 8.14 COL 4 WIDGET-ID 600
     "                     SELECT DATE" VIEW-AS TEXT
          SIZE 40 BY 1.19 AT ROW 1 COL 131 WIDGET-ID 28
     "PRODUCT LIST" VIEW-AS TEXT
          SIZE 27 BY 1.19 AT ROW 1 COL 99 WIDGET-ID 30
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 173 BY 24.05
         TITLE "SALES REPORT" WIDGET-ID 300.


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
         TITLE              = "Sales Report screen"
         HEIGHT             = 23.71
         WIDTH              = 173
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
ASSIGN FRAME FRAME-A:FRAME = FRAME fMain:HANDLE.

/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME FRAME-A
                                                                        */
/* BROWSE-TAB BROWSE-9 BUTTON-1 FRAME-A */
/* BROWSE-TAB BROWSE-7 BROWSE-9 FRAME-A */
/* BROWSE-TAB BROWSE-11 BROWSE-7 FRAME-A */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-11
/* Query rebuild information for BROWSE BROWSE-11
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH temp-inventory.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-11 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-7
/* Query rebuild information for BROWSE BROWSE-7
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH temp-date-prodt-report.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-7 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-9
/* Query rebuild information for BROWSE BROWSE-9
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH temp-totalrev.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-9 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Sales Report screen */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Sales Report screen */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-A
&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 wWin
ON CHOOSE OF BUTTON-1 IN FRAME FRAME-A /* EXIT */
CURRENT-WINDOW:HIDDEN = TRUE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-2 wWin
ON CHOOSE OF BUTTON-2 IN FRAME FRAME-A /* EXPORT */
DO:
  RUN export-data-to-csv.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-3 wWin
ON CHOOSE OF BUTTON-3 IN FRAME FRAME-A /* SUBMIT */
DO:
  BUTTON-3:SENSITIVE = FALSE.
  BUTTON-2:SENSITIVE = TRUE.
  IF COMBO-BOX-2:SCREEN-VALUE = "Sales by Date" THEN
  DO:
   RUN Sales-by-Date.
  END.
  ELSE IF COMBO-BOX-2:SCREEN-VALUE = "Sales by Product" THEN
  DO:
  RUN sales-by-product.    
  END.
  ELSE IF COMBO-BOX-2:SCREEN-VALUE = "Total Revenue Report" THEN
  DO:
     RUN total-revenue. 
  END.
  ELSE RUN inventory.
END.

/*Sales by Date
Sales by Product
Total Revenue Report
Inventory Details*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME COMBO-BOX-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL COMBO-BOX-2 wWin
ON VALUE-CHANGED OF COMBO-BOX-2 IN FRAME FRAME-A /* Report Type */
DO:
  IF string(COMBO-BOX-2:SCREEN-VALUE) = "Sales by Date" THEN
DO:
 EMPTY TEMP-TABLE temp-date-prodt-report.
 SELECT-3:SENSITIVE = FALSE.
 STRDATE-FILL:SENSITIVE = TRUE.
 ENDATE-FILL:SENSITIVE = TRUE.
 BUTTON-3:SENSITIVE = FALSE.
 BUTTON-2:SENSITIVE = FALSE.
 BROWSE-7:HIDDEN = FALSE.
 BROWSE-9:HIDDEN = TRUE.
 BROWSE-11:HIDDEN = TRUE.
 SELECT-3:SCREEN-VALUE = ?.
END.
ELSE IF string(COMBO-BOX-2:SCREEN-VALUE) = "Sales by Product" THEN
DO:
 EMPTY TEMP-TABLE temp-date-prodt-report.
 SELECT-3:SENSITIVE = TRUE.
 STRDATE-FILL:SENSITIVE = FALSE.
 ENDATE-FILL:SENSITIVE = FALSE.
 BUTTON-3:SENSITIVE = FALSE.
 BUTTON-2:SENSITIVE = FALSE.
 BROWSE-7:HIDDEN = FALSE.
 BROWSE-9:HIDDEN = TRUE.
 BROWSE-11:HIDDEN = TRUE.
END.
ELSE IF string(COMBO-BOX-2:SCREEN-VALUE) = "Total Revenue Report" THEN
DO:
 EMPTY TEMP-TABLE temp-totalrev.
 SELECT-3:SENSITIVE = FALSE.
 STRDATE-FILL:SENSITIVE = FALSE.
 ENDATE-FILL:SENSITIVE = FALSE.
 BUTTON-3:SENSITIVE = TRUE.
 BUTTON-2:SENSITIVE = FALSE.
 BROWSE-7:HIDDEN = TRUE.
 BROWSE-9:HIDDEN = FALSE.
 BROWSE-11:HIDDEN = TRUE.
 SELECT-3:SCREEN-VALUE = ?.
END.
ELSE DO:
 EMPTY TEMP-TABLE temp-inventory.
 SELECT-3:SENSITIVE = FALSE.
 STRDATE-FILL:SENSITIVE = FALSE.
 ENDATE-FILL:SENSITIVE = FALSE.
 BUTTON-3:SENSITIVE = TRUE.
 BUTTON-2:SENSITIVE = FALSE.
 BROWSE-7:HIDDEN = TRUE.
 BROWSE-9:HIDDEN = TRUE.
 BROWSE-11:HIDDEN = FALSE.
 SELECT-3:SCREEN-VALUE = ?.
END.
END.

/*Sales by Date
Sales by Product
Total Revenue Report
Inventory Details*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME SELECT-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL SELECT-3 wWin
ON VALUE-CHANGED OF SELECT-3 IN FRAME FRAME-A
DO:
  IF STRING(SELECT-3:SCREEN-VALUE) = "" THEN DO:
    MESSAGE "Please chose a product first" VIEW-AS ALERT-BOX INFORMATION.
  END.
  ELSE DO:
    BUTTON-3:SENSITIVE = TRUE.
    //BUTTON-2:SENSITIVE = TRUE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME STRDATE-FILL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL STRDATE-FILL wWin
ON LEAVE OF STRDATE-FILL IN FRAME FRAME-A /* STRAT DATE */
DO:
  IF STRING(STRDATE-FILL:SCREEN-VALUE) = "" OR STRING(ENDATE-FILL:SCREEN-VALUE) = "" THEN DO:
    MESSAGE "Please enter both dates" VIEW-AS ALERT-BOX INFORMATION.
  END.
  ELSE DO:
    BUTTON-3:SENSITIVE = TRUE.
    //BUTTON-2:SENSITIVE = TRUE.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fMain
&Scoped-define BROWSE-NAME BROWSE-11
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wWin 


/* ***************************  Main Block  *************************** */

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
   SELECT-3:SENSITIVE = FALSE.
   STRDATE-FILL:SENSITIVE = FALSE.
   ENDATE-FILL:SENSITIVE = FALSE.
   BUTTON-3:SENSITIVE = FALSE.
   BUTTON-2:SENSITIVE = FALSE.
  
 
   FOR EACH ProductMaster NO-LOCK:
    SELECT-3:ADD-LAST(ProductMaster.productname).
END.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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
  VIEW FRAME fMain IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
  DISPLAY COMBO-BOX-2 SELECT-3 STRDATE-FILL ENDATE-FILL 
      WITH FRAME FRAME-A IN WINDOW wWin.
  ENABLE BUTTON-3 COMBO-BOX-2 SELECT-3 STRDATE-FILL BUTTON-2 ENDATE-FILL 
         BUTTON-1 BROWSE-9 BROWSE-7 BROWSE-11 
      WITH FRAME FRAME-A IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-A}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE export-data-to-csv wWin 
PROCEDURE export-data-to-csv :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-A:
   rdate = TODAY.
   ftime = STRING(TIME,"HH:MM:SS").
   fname = STRING(rdate, "99-99-9999") + "  " + REPLACE(ftime, ":", "-").
   dname = "C:\Users\ayush\OneDrive\Documents\Retail-Inventory-and-Sales-Management-System\Export data\Report Num-" + STRING(fname) + ".csv".
   

OUTPUT STREAM s1 TO VALUE(dname).

IF COMBO-BOX-2:SCREEN-VALUE = "Sales by Date" THEN
DO:
   PUT STREAM s1 UNFORMATTED "productid,productname,transactiondate,quantitysold,totalprice" SKIP.
      FOR EACH temp-date-prodt-report no-lock:
      EXPORT STREAM s1 DELIMITER "," temp-date-prodt-report .
      END.
   OUTPUT STREAM s1 CLOSE.     
END.

ELSE IF COMBO-BOX-2:SCREEN-VALUE = "Sales by Product" THEN
DO:
   PUT STREAM s1 UNFORMATTED "productid,productname,transactiondate,quantitysold,totalprice" SKIP.
      FOR EACH temp-date-prodt-report no-lock:
      EXPORT STREAM s1 DELIMITER "," temp-date-prodt-report .
      END.
   OUTPUT STREAM s1 CLOSE.     
END.

ELSE IF COMBO-BOX-2:SCREEN-VALUE = "Total Revenue Report" THEN
DO:
   PUT STREAM s1 UNFORMATTED "productid,productname,quantitysold,totalprice" SKIP.   
      FOR EACH temp-totalrev no-lock:
      EXPORT STREAM s1 DELIMITER "," temp-totalrev.
      END.
   OUTPUT STREAM s1 CLOSE.     
END.

ELSE 
   PUT STREAM s1 UNFORMATTED "productid,productname,stockquantity,price,category" SKIP.  
      FOR EACH temp-inventory no-lock:
      EXPORT STREAM s1 DELIMITER "," temp-inventory.
      END.
   OUTPUT STREAM s1 CLOSE.     
END.

MESSAGE "Your file (Report Num-" + fname + ") has been saved to C:\Users\ayush\OneDrive\Documents\Retail-Inventory-and-Sales-Management-System\Export data" 
       VIEW-AS ALERT-BOX INFORMATION.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE inventory wWin 
PROCEDURE inventory :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-A:
EMPTY TEMP-TABLE temp-inventory.
FOR EACH ProductMaster:
CREATE temp-inventory.
ASSIGN 
            temp-inventory.productid  = ProductMaster.productid
            temp-inventory.productname = ProductMaster.productname
            temp-inventory.stockquantity = ProductMaster.stockquantity
            temp-inventory.category = ProductMaster.category
            temp-inventory.price = ProductMaster.price.
END.
  OPEN QUERY BROWSE-11 FOR EACH temp-inventory.
    BROWSE-11:REFRESH().
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Sales-by-Date wWin 
PROCEDURE Sales-by-Date :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-A:

EMPTY TEMP-TABLE temp-date-prodt-report.

   strdate = DATE(STRDATE-FILL:SCREEN-VALUE).
   endate = DATE(ENDATE-FILL:SCREEN-VALUE).
   
      FOR EACH Salestransaction NO-LOCK WHERE 
                                  Salestransaction.transactiondate >= strdate AND 
                                  Salestransaction.transactiondate <= endate,EACH ProductMaster NO-LOCK WHERE 
                                  ProductMaster.productid = Salestransaction.productid:
      CREATE temp-date-prodt-report.
      ASSIGN
            temp-date-prodt-report.productid  = ProductMaster.productid
            temp-date-prodt-report.productname = ProductMaster.productname
            temp-date-prodt-report.transactiondate = SalesTransaction.transactiondate
            temp-date-prodt-report.quantitysold = SalesTransaction.quantitysold
            temp-date-prodt-report.totalprice = SalesTransaction.totalprice.
      END.
         OPEN QUERY BROWSE-7 FOR EACH temp-date-prodt-report.
         BROWSE-7:REFRESH().
      END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE sales-by-product wWin 
PROCEDURE sales-by-product :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-A:
EMPTY TEMP-TABLE temp-date-prodt-report.
DEFINE VARIABLE choice AS CHARACTER NO-UNDO.
choice = SELECT-3:SCREEN-VALUE.

 FOR EACH productmaster NO-LOCK WHERE choice = productmaster.productname,EACH salestransaction WHERE salestransaction.productid = productmaster.productid:
    IF AVAILABLE productmaster THEN
 DO:
 CREATE temp-date-prodt-report.
    ASSIGN
         temp-date-prodt-report.productid  = ProductMaster.productid
         temp-date-prodt-report.productname = ProductMaster.productname
         temp-date-prodt-report.transactiondate = SalesTransaction.transactiondate
         temp-date-prodt-report.quantitysold = SalesTransaction.quantitysold
         temp-date-prodt-report.totalprice = SalesTransaction.totalprice.
    END.
    OPEN QUERY BROWSE-7 FOR EACH temp-date-prodt-report.
    BROWSE-7:REFRESH().    
    END.
    
    //ELSE MESSAGE "NO record for this product" VIEW-AS ALERT-BOX INFO.

 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE total-revenue wWin 
PROCEDURE total-revenue :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-A:
EMPTY TEMP-TABLE temp-totalrev.
FOR EACH productmaster NO-LOCK ,EACH salestransaction WHERE salestransaction.productid = productmaster.productid:
CREATE temp-totalrev.
ASSIGN
         temp-totalrev.productid  = ProductMaster.productid
         temp-totalrev.productname = ProductMaster.productname
         temp-totalrev.quantitysold = SalesTransaction.quantitysold
         temp-totalrev.totalprice = SalesTransaction.totalprice.
END.
    OPEN QUERY BROWSE-9 FOR EACH temp-totalrev.
    BROWSE-9:REFRESH().
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


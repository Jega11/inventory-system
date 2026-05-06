&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM1
&ANALYZE-RESUME
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


 




/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
{src/adm2/widgetprto.i}

   DEFINE VARIABLE tempname  AS CHARACTER NO-UNDO.
   DEFINE VARIABLE temppass   AS CHARACTER NO-UNDO.
   DEFINE VARIABLE attemptscount AS INTEGER  NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER WINDOW

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fMain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-3 IMAGE-4 FILL-IN-1 FILL-IN-2 Login ~
BUTTON-2 BUTTON-1 
&Scoped-Define DISPLAYED-OBJECTS FILL-IN-1 FILL-IN-2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-1 
     LABEL "CLOSE" 
     SIZE 15 BY 1.14.

DEFINE BUTTON BUTTON-2 
     LABEL "RESET" 
     SIZE 15 BY 1.19.

DEFINE BUTTON Login 
     LABEL "LOGIN" 
     SIZE 15 BY 1.19.

DEFINE VARIABLE FILL-IN-1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1.67
     BGCOLOR 8  NO-UNDO.

DEFINE VARIABLE FILL-IN-2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1.67
     BGCOLOR 8  NO-UNDO.

DEFINE IMAGE IMAGE-3
     FILENAME "screenshot 2025-07-12 223608.png":U
     STRETCH-TO-FIT
     SIZE 7 BY 1.67.

DEFINE IMAGE IMAGE-4
     FILENAME "screenshot 2025-07-12 223337.png":U
     STRETCH-TO-FIT
     SIZE 7 BY 1.67.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     FILL-IN-1 AT ROW 7.19 COL 53 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     FILL-IN-2 AT ROW 10.76 COL 53 COLON-ALIGNED NO-LABEL WIDGET-ID 6 PASSWORD-FIELD 
     Login AT ROW 16 COL 27 WIDGET-ID 10
     BUTTON-2 AT ROW 16 COL 52 WIDGET-ID 14
     BUTTON-1 AT ROW 16 COL 76 WIDGET-ID 12
     "   Username:" VIEW-AS TEXT
          SIZE 15 BY 1.67 AT ROW 7.19 COL 34 WIDGET-ID 16
          BGCOLOR 8 
     "   Password:" VIEW-AS TEXT
          SIZE 15 BY 1.67 AT ROW 10.76 COL 34 WIDGET-ID 18
          BGCOLOR 8 
     "                                 RETAIL PORTAL LOGIN" VIEW-AS TEXT
          SIZE 64 BY 2.62 AT ROW 1.95 COL 27 WIDGET-ID 8
          BGCOLOR 8 
     IMAGE-3 AT ROW 10.76 COL 27 WIDGET-ID 20
     IMAGE-4 AT ROW 7.19 COL 27 WIDGET-ID 22
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114 BY 20.95 WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
   Other Settings: APPSERVER
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW wWin ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert SmartWindow title>"
         HEIGHT             = 20.95
         WIDTH              = 114
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
/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */
ASSIGN 
       FILL-IN-1:AUTO-RESIZE IN FRAME fMain      = TRUE.

ASSIGN 
       FILL-IN-2:AUTO-RESIZE IN FRAME fMain      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* <insert SmartWindow title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* <insert SmartWindow title> */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-1 wWin
ON CHOOSE OF BUTTON-1 IN FRAME fMain /* CLOSE */
QUIT.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-2 wWin
ON CHOOSE OF BUTTON-2 IN FRAME fMain /* RESET */
DO:
    RUN resetfillins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Login
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Login wWin
ON CHOOSE OF Login IN FRAME fMain /* LOGIN */
DO:
  RUN login.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
  DISPLAY FILL-IN-1 FILL-IN-2 
      WITH FRAME fMain IN WINDOW wWin.
  ENABLE IMAGE-3 IMAGE-4 FILL-IN-1 FILL-IN-2 Login BUTTON-2 BUTTON-1 
      WITH FRAME fMain IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE login wWin 
PROCEDURE login :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO TRANSACTION:
   DO WITH FRAME fMain:
   ASSIGN
      tempname = string(FILL-IN-1:SCREEN-VALUE)
      temppass = string(FILL-IN-2:SCREEN-VALUE).
      
   IF tempname = "" OR temppass = "" THEN DO:
      MESSAGE "Please enter both username and password" VIEW-AS ALERT-BOX ERROR.
      RETURN.
   END.

   FIND FIRST retailuser EXCLUSIVE-LOCK
        WHERE retailuser.username = tempname NO-ERROR.
   IF NOT AVAILABLE retailuser THEN DO:
      MESSAGE "User not found." VIEW-AS ALERT-BOX ERROR.
      RETURN.
   END.
   ELSE DO:
      IF retailuser.password <> temppass THEN DO:
         ASSIGN retailuser.attempts = retailuser.attempts + 1.
         
         IF retailuser.attempts >= 3 THEN DO:
         
            MESSAGE "You have entered the wrong password more than three times. Your account has been temporarily blocked."
                   VIEW-AS ALERT-BOX ERROR. 
                   ASSIGN retailuser.islocked = TRUE.
                   END.      
         ELSE
            MESSAGE "Wrong password" VIEW-AS ALERT-BOX WARNING.
         RETURN.
      END.
          ASSIGN retailuser.attempts = 0.
          ASSIGN retailuser.islocked = FALSE.
          ASSIGN                      
               FILL-IN-1:SCREEN-VALUE  = ""
               FILL-IN-2:SCREEN-VALUE  = "".
      IF retailuser.isAdmin THEN 
         DO:
         RUN master-screen.w.
         END.
      ELSE DO:   
          RUN sales-entrey.w.
         END.
      END.
         
   END.
END.
QUIT.
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
DO WITH FRAME fmain:
    ASSIGN                      
    FILL-IN-1:SCREEN-VALUE  = ""
    FILL-IN-2:SCREEN-VALUE  = "".
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


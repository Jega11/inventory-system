&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI ADM2
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

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

{src/adm2/widgetprto.i}
DEFINE VARIABLE tempname  AS CHARACTER NO-UNDO.
DEFINE VARIABLE temppass   AS CHARACTER NO-UNDO.
DEFINE VARIABLE attemptscount AS INTEGER  NO-UNDO.
DEFINE VARIABLE oUserService AS CLASS business.UserService NO-UNDO.
{data/ttDefinitions.i}

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

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-5 IMAGE-19 IMAGE-20 IMAGE-23 IMAGE-24 ~
IMAGE-25 IMAGE-26 FILL-IN-1 FILL-IN-2
&Scoped-Define DISPLAYED-OBJECTS FILL-IN-1 FILL-IN-2

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE FILL-IN-1 AS CHARACTER FORMAT "X(256)":U
     VIEW-AS FILL-IN
     SIZE 37 BY 1.48
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE FILL-IN-2 AS CHARACTER FORMAT "X(256)":U
     VIEW-AS FILL-IN
     SIZE 37 BY 1.48
     BGCOLOR 8  NO-UNDO.

DEFINE IMAGE IMAGE-19
     FILENAME "C:/Users/ayush/Downloads/username (3).png":U
     STRETCH-TO-FIT
     SIZE 28 BY 3.81.

DEFINE IMAGE IMAGE-20
     FILENAME "C:/Users/ayush/Downloads/username (1).png":U
     STRETCH-TO-FIT
     SIZE 28 BY 3.81.

DEFINE IMAGE IMAGE-23
     FILENAME "C:/Users/ayush/Downloads/login to you account (1).png":U
     STRETCH-TO-FIT
     SIZE 28 BY 3.81.

DEFINE IMAGE IMAGE-24
     FILENAME "C:/Users/ayush/Downloads/login to you account.png":U
     STRETCH-TO-FIT
     SIZE 28 BY 3.76.

DEFINE IMAGE IMAGE-25
     FILENAME "C:/Users/ayush/Downloads/reset (1).png":U
     STRETCH-TO-FIT
     SIZE 11 BY 1.67.

DEFINE IMAGE IMAGE-26
     FILENAME "C:/Users/ayush/Downloads/reset.png":U
     STRETCH-TO-FIT
     SIZE 11 BY 1.67.

DEFINE IMAGE IMAGE-5
     FILENAME "C:/Users/ayush/Downloads/username.png":U
     STRETCH-TO-FIT
     SIZE 150 BY 19.05.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     FILL-IN-1 AT ROW 6.95 COL 13 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     FILL-IN-2 AT ROW 10.52 COL 13 COLON-ALIGNED NO-LABEL WIDGET-ID 6 PASSWORD-FIELD
     IMAGE-5 AT ROW 1 COL 1 WIDGET-ID 2
     IMAGE-19 AT ROW 15.52 COL 37 WIDGET-ID 58
     IMAGE-20 AT ROW 15.29 COL 37 WIDGET-ID 60
     IMAGE-23 AT ROW 15.29 COL 7 WIDGET-ID 66
     IMAGE-24 AT ROW 15.29 COL 7 WIDGET-ID 68
     IMAGE-25 AT ROW 12.67 COL 42 WIDGET-ID 70
     IMAGE-26 AT ROW 12.67 COL 42 WIDGET-ID 72
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY
         SIDE-LABELS NO-UNDERLINE THREE-D
         AT X 0 Y 0
         SIZE-PIXELS 752 BY 401 WIDGET-ID 100.


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
         TITLE              = "Login screen"
         HEIGHT             = 19.05
         WIDTH              = 149.6
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME





/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Login screen */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Login screen */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME IMAGE-20
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL IMAGE-20 wWin
ON MOUSE-SELECT-CLICK OF IMAGE-20 IN FRAME fMain
DO:
  IMAGE-20:HIDDEN = TRUE.
  PAUSE 0.1 NO-MESSAGE.
  IMAGE-20:HIDDEN = FALSE.
  QUIT.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME IMAGE-24
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL IMAGE-24 wWin
ON MOUSE-SELECT-CLICK OF IMAGE-24 IN FRAME fMain
DO:
  IMAGE-24:HIDDEN = TRUE.
  PAUSE 0.1 NO-MESSAGE.
  IMAGE-24:HIDDEN = FALSE.
  RUN login.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME IMAGE-26
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL IMAGE-26 wWin
ON MOUSE-SELECT-CLICK OF IMAGE-26 IN FRAME fMain
DO:
  IMAGE-26:HIDDEN = TRUE.
  PAUSE 0.1 NO-MESSAGE.
  IMAGE-26:HIDDEN = FALSE.
  RUN resetfillins.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wWin


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm2/windowmn.i}

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
  ENABLE IMAGE-5 IMAGE-19 IMAGE-20 IMAGE-23 IMAGE-24 IMAGE-25 IMAGE-26
         FILL-IN-1 FILL-IN-2
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
DEFINE VARIABLE lAuthSuccess AS LOGICAL NO-UNDO.

DO WITH FRAME fMain:
   ASSIGN
      tempname = string(FILL-IN-1:SCREEN-VALUE)
      temppass = string(FILL-IN-2:SCREEN-VALUE).

   IF tempname = "" OR temppass = "" THEN DO:
      MESSAGE "Please enter both username and password" VIEW-AS ALERT-BOX ERROR.
      RETURN.
   END.

   oUserService = NEW business.UserService().
   lAuthSuccess = oUserService:AuthenticateUser(INPUT tempname, INPUT temppass, OUTPUT TABLE ttUser).

   IF lAuthSuccess THEN DO:
       FIND FIRST ttUser NO-ERROR.
       IF AVAILABLE ttUser THEN DO:
           ASSIGN
               FILL-IN-1:SCREEN-VALUE  = ""
               FILL-IN-2:SCREEN-VALUE  = "".

           IF ttUser.roleName = "Admin" OR ttUser.roleName = "Manager" THEN
               DO:
               RUN master-screen.w.
               END.
           ELSE DO:
               RUN sales-entrey.w.
               END.
       END.
   END.
   ELSE DO:
       MESSAGE "Authentication failed. User not found, incorrect password, or account locked." VIEW-AS ALERT-BOX ERROR.
       RETURN.
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

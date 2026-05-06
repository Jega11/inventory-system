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

DEFINE TEMP-TABLE ttProductList NO-UNDO
    FIELD productid LIKE ProductMaster.productid
    FIELD productname LIKE ProductMaster.productname
    FIELD transactionid LIKE salestransaction.transactionid
    FIELD transactiondate LIKE salestransaction.transactiondate
    FIELD quantitysold LIKE salestransaction.quantitysold
    FIELD totalprice LIKE salestransaction.totalprice.

DEFINE BUFFER buff-sales FOR salestransaction.

DEFINE VARIABLE temp-quant         AS INTEGER NO-UNDO.
DEFINE VARIABLE temp-price         AS DECIMAL NO-UNDO.
DEFINE VARIABLE temp-total         AS DECIMAL NO-UNDO.
DEFINE VARIABLE new-transaction-id AS INTEGER NO-UNDO.
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

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wWin AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-CLOSE
     LABEL "CLOSE"
     SIZE 19 BY 2.

DEFINE BUTTON BUTTON-SUBMIT-SALE
     LABEL "SUBMIT SALE"
     SIZE 19 BY 2.

DEFINE VARIABLE DATE-FILL AS CHARACTER FORMAT "X(256)":U
     LABEL "DATE"
     VIEW-AS FILL-IN
     SIZE 20 BY 1 NO-UNDO.

DEFINE VARIABLE PRICE-FILL AS CHARACTER FORMAT "X(256)":U
     LABEL "PRICE"
     VIEW-AS FILL-IN
     SIZE 20 BY 1 NO-UNDO.

DEFINE VARIABLE PRODID-FILL AS CHARACTER FORMAT "X(256)":U
     LABEL "PRODUCT ID"
     VIEW-AS FILL-IN
     SIZE 19 BY 1 NO-UNDO.

DEFINE VARIABLE PRODNM-FILL AS CHARACTER FORMAT "X(256)":U
     LABEL "PRODUCT NAME"
     VIEW-AS FILL-IN
     SIZE 30 BY 1 NO-UNDO.

DEFINE VARIABLE QUANTITY-SOLD-FILL AS CHARACTER FORMAT "X(256)":U
     LABEL "QUANTITY SOLD"
     VIEW-AS FILL-IN
     SIZE 22 BY 1 NO-UNDO.

DEFINE VARIABLE STO-FILL AS CHARACTER FORMAT "X(256)":U
     LABEL "STOCK QUANTITY"
     VIEW-AS FILL-IN
     SIZE 18 BY 1 NO-UNDO.

DEFINE VARIABLE TOTALPR-FILL AS CHARACTER FORMAT "X(256)":U
     LABEL "TOTAL PRICE"
     VIEW-AS FILL-IN
     SIZE 18 BY 1 NO-UNDO.

DEFINE VARIABLE SELECT-2 AS CHARACTER
     VIEW-AS SELECTION-LIST SINGLE SCROLLBAR-VERTICAL
     SIZE 44 BY 10.95 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY
         SIDE-LABELS NO-UNDERLINE THREE-D
         AT COL 1 ROW 1
         SIZE 133.2 BY 21.48 WIDGET-ID 100.

DEFINE FRAME FRAME-H
     PRODNM-FILL AT ROW 3 COL 86 COLON-ALIGNED WIDGET-ID 14
     SELECT-2 AT ROW 3.38 COL 7 NO-LABEL WIDGET-ID 30
     STO-FILL AT ROW 4.81 COL 86 COLON-ALIGNED WIDGET-ID 16
     PRICE-FILL AT ROW 6.71 COL 86 COLON-ALIGNED WIDGET-ID 8
     QUANTITY-SOLD-FILL AT ROW 8.62 COL 86 COLON-ALIGNED WIDGET-ID 10
     TOTALPR-FILL AT ROW 10.52 COL 86 COLON-ALIGNED WIDGET-ID 12
     DATE-FILL AT ROW 12.43 COL 86 COLON-ALIGNED WIDGET-ID 20
     PRODID-FILL AT ROW 14.33 COL 86 COLON-ALIGNED WIDGET-ID 26
     BUTTON-CLOSE AT ROW 17.19 COL 22 WIDGET-ID 6
     BUTTON-SUBMIT-SALE AT ROW 17.19 COL 92 WIDGET-ID 2
     "PRODUCT LIST" VIEW-AS TEXT
          SIZE 44 BY 1.67 AT ROW 1.71 COL 7 WIDGET-ID 24
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY
         SIDE-LABELS NO-UNDERLINE THREE-D
         AT COL 3 ROW 1
         SIZE 131 BY 21.43
         TITLE "SALES ENTRY" WIDGET-ID 200.


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
         TITLE              = "Sales Entry screen"
         HEIGHT             = 21.81
         WIDTH              = 134.8
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
ASSIGN FRAME FRAME-H:FRAME = FRAME fMain:HANDLE.

/* SETTINGS FOR FRAME fMain
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME FRAME-H
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wWin)
THEN wWin:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME





/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wWin
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON END-ERROR OF wWin /* Sales Entry screen */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wWin wWin
ON WINDOW-CLOSE OF wWin /* Sales Entry screen */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-H
&Scoped-define SELF-NAME BUTTON-CLOSE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-CLOSE wWin
ON CHOOSE OF BUTTON-CLOSE IN FRAME FRAME-H /* CLOSE */
DO:
 CURRENT-WINDOW:HIDDEN = TRUE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-SUBMIT-SALE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-SUBMIT-SALE wWin
ON CHOOSE OF BUTTON-SUBMIT-SALE IN FRAME FRAME-H /* SUBMIT SALE */
DO:
  RUN submitsale.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME QUANTITY-SOLD-FILL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL QUANTITY-SOLD-FILL wWin
ON VALUE-CHANGED OF QUANTITY-SOLD-FILL IN FRAME FRAME-H /* QUANTITY SOLD */
DO :
 RUN totalprice.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME SELECT-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL SELECT-2 wWin
ON SELECTION OF SELECT-2 IN FRAME FRAME-H
DO:
    RUN populateProductFields.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL SELECT-2 wWin
ON VALUE-CHANGED OF SELECT-2 IN FRAME FRAME-H
DO:
    RUN populateProductFields.
    QUANTITY-SOLD-FILL:SENSITIVE = TRUE.
    QUANTITY-SOLD-FILL:SCREEN-VALUE = "".
    RUN totalprice.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fMain
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


  RUN disablefillins.

  DEFINE VARIABLE oProductService AS CLASS business.ProductService NO-UNDO.
  DEFINE VARIABLE displayy AS CHARACTER NO-UNDO.

  oProductService = NEW business.ProductService().

  EMPTY TEMP-TABLE ttProduct.
  oProductService:GetAllProducts(OUTPUT TABLE ttProduct).

  FOR EACH ttProduct:
    displayy = ttProduct.productName + "-" + STRING(ttProduct.productId).
    SELECT-2:ADD-LAST(displayy).
    CREATE ttProductList.
    ASSIGN
        ttProductList.productid = ttProduct.productId
        ttProductList.productname = displayy.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disablefillins wWin
PROCEDURE disablefillins :
/*------------------------------------------------------------------------------
  Purpose:
  Parameters:  <none>
  Notes:
------------------------------------------------------------------------------*/
DO TRANSACTION WITH FRAME FRAME-H:
 ASSIGN
 QUANTITY-SOLD-FILL:SENSITIVE = FALSE
 PRODNM-FILL:SENSITIVE = FALSE
 STO-FILL:SENSITIVE = FALSE
 PRICE-FILL:SENSITIVE = FALSE
 TOTALPR-FILL:SENSITIVE = FALSE
 PRODID-FILL:SENSITIVE = FALSE
 DATE-FILL:SENSITIVE = FALSE.
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
  DISPLAY PRODNM-FILL SELECT-2 STO-FILL PRICE-FILL QUANTITY-SOLD-FILL
          TOTALPR-FILL DATE-FILL PRODID-FILL
      WITH FRAME FRAME-H IN WINDOW wWin.
  ENABLE PRODNM-FILL SELECT-2 STO-FILL PRICE-FILL QUANTITY-SOLD-FILL
         TOTALPR-FILL DATE-FILL PRODID-FILL BUTTON-CLOSE BUTTON-SUBMIT-SALE
      WITH FRAME FRAME-H IN WINDOW wWin.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-H}
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE load-data-to-temp-table wWin
PROCEDURE load-data-to-temp-table :
/*------------------------------------------------------------------------------
  Purpose:
  Parameters:  <none>
  Notes:
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-H:
   CREATE ttProductList NO-ERROR.
      IF ERROR-STATUS:ERROR THEN
      MESSAGE ERROR-STATUS:GET-MESSAGE(1) VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
      ASSIGN
      ttProductList.productname = string(PRODNM-FILL:SCREEN-VALUE)
      ttProductList.quantitysold = integer(QUANTITY-SOLD-FILL:SCREEN-VALUE)
      ttProductList.totalprice = integer(TOTALPR-FILL:SCREEN-VALUE)
      ttProductList.transactiondate = DATE(DATE-FILL:SCREEN-VALUE)
      ttProductList.productid = integer(PRODID-FILL:SCREEN-VALUE).
   END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE populateProductFields wWin
PROCEDURE populateProductFields :
/*------------------------------------------------------------------------------
  Purpose: Populates product fields from the selection list.
  Notes:   Relies on ttProductList to map selection to ProductMaster via service.
------------------------------------------------------------------------------*/
DEFINE VARIABLE temp-Selected AS CHARACTER NO-UNDO.
DEFINE VARIABLE temp-ProductId AS INTEGER NO-UNDO.
DEFINE VARIABLE oProductService AS CLASS business.ProductService NO-UNDO.

DO WITH FRAME FRAME-H:
   temp-Selected = SELECT-2:SCREEN-VALUE.
   FIND FIRST ttProductList WHERE ttProductList.productname = temp-Selected NO-ERROR.
      IF ERROR-STATUS:ERROR THEN
      MESSAGE ERROR-STATUS:GET-MESSAGE(1) VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
      IF AVAILABLE ttProductList THEN DO:
            temp-ProductId = ttProductList.productid.

            oProductService = NEW business.ProductService().
            EMPTY TEMP-TABLE ttProduct.
            oProductService:GetProductById(INPUT temp-ProductId, OUTPUT TABLE ttProduct).

            FIND FIRST ttProduct NO-ERROR.
            IF AVAILABLE ttProduct THEN DO:
                ASSIGN
                    PRODNM-FILL:SCREEN-VALUE = ttProduct.productName
                    STO-FILL:SCREEN-VALUE = STRING(ttProduct.stockQuantity)
                    PRICE-FILL:SCREEN-VALUE = STRING(ttProduct.price)
                    PRODID-FILL:SCREEN-VALUE = STRING(ttProduct.productId)
                    DATE-FILL:SCREEN-VALUE = STRING(TODAY).
            END.
     END.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE submitsale wWin
PROCEDURE submitsale :
/*------------------------------------------------------------------------------
  Purpose:  Handles the sale submission with validation and proper error handling.
------------------------------------------------------------------------------*/
DEFINE VARIABLE oSalesService AS CLASS business.SalesService NO-UNDO.
DEFINE VARIABLE lSuccess AS LOGICAL NO-UNDO.
DEFINE VARIABLE oProductServiceRefresh AS CLASS business.ProductService NO-UNDO.

DO WITH FRAME FRAME-H:
   RUN load-data-to-temp-table.

   EMPTY TEMP-TABLE ttSalesHeader.
   EMPTY TEMP-TABLE ttSalesDetail.

   CREATE ttSalesHeader.
   ASSIGN
      ttSalesHeader.customerId = 1
      ttSalesHeader.date = TODAY
      ttSalesHeader.totalAmount = ttProductList.totalprice
      ttSalesHeader.netAmount = ttProductList.totalprice.

   IF ttProductList.quantitysold <= 0 THEN DO:
      MESSAGE "Quantity sold cannot be less than 1." VIEW-AS ALERT-BOX ERROR.
      RETURN.
   END.

   CREATE ttSalesDetail.
   ASSIGN
      ttSalesDetail.productId = ttProductList.productid
      ttSalesDetail.quantity = ttProductList.quantitysold
      ttSalesDetail.price = ttProductList.totalprice / ttProductList.quantitysold.

   oSalesService = NEW business.SalesService().
   lSuccess = oSalesService:CreateSale(INPUT TABLE ttSalesHeader, INPUT TABLE ttSalesDetail).

   IF lSuccess THEN DO:
       MESSAGE "Sale submitted successfully!" VIEW-AS ALERT-BOX INFO.
       QUANTITY-SOLD-FILL:SCREEN-VALUE = "".

       /* Refresh the available stock displayed in the UI */
       oProductServiceRefresh = NEW business.ProductService().
       EMPTY TEMP-TABLE ttProduct.
       oProductServiceRefresh:GetProductById(INPUT ttProductList.productid, OUTPUT TABLE ttProduct).

       FIND FIRST ttProduct NO-ERROR.
       IF AVAILABLE ttProduct THEN DO:
           STO-FILL:SCREEN-VALUE = STRING(ttProduct.stockQuantity).
       END.
   END.
   ELSE DO:
       MESSAGE "Sale submission failed due to validation (stock unavailable) or system error." VIEW-AS ALERT-BOX ERROR.
   END.
END.
END PROCEDURE.































































 //////////////////////////////////////////////////////////////////////////////////




/* DO TRANSACTION WITH FRAME FRAME-H:
    RUN load-data-to-temp-table.
    DEFINE VARIABLE new-transaction-id AS INTEGER NO-UNDO.

    FIND LAST SalesTransaction NO-LOCK NO-ERROR.
    IF AVAILABLE SalesTransaction THEN
        new-transaction-id = SalesTransaction.transactionid + 1.
    ELSE
        new-transaction-id = 1.


    FIND ProductMaster WHERE ProductMaster.productid = INTEGER(PRODID-FILL:SCREEN-VALUE) EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE ProductMaster THEN DO:
        IF INTEGER(QUANTITY-SOLD-FILL:SCREEN-VALUE) <= ProductMaster.stockquantity THEN DO:
            ProductMaster.stockquantity = ProductMaster.stockquantity - INTEGER(QUANTITY-SOLD-FILL:SCREEN-VALUE).
            CREATE SalesTransaction.
            ASSIGN
                SalesTransaction.totalprice = DECIMAL(TOTALPR-FILL:SCREEN-VALUE)
                SalesTransaction.transactionid = new-transaction-id
                SalesTransaction.productid = INTEGER(PRODID-FILL:SCREEN-VALUE)
                SalesTransaction.quantitysold = INTEGER(QUANTITY-SOLD-FILL:SCREEN-VALUE)
                SalesTransaction.transactiondate = TODAY.
            MESSAGE "Sale submitted successfully!" VIEW-AS ALERT-BOX INFO.

            QUANTITY-SOLD-FILL:SCREEN-VALUE = "".
            STO-FILL:SCREEN-VALUE = STRING(ProductMaster.stockquantity).
        END.
        ELSE DO:
            MESSAGE "Stock not available" VIEW-AS ALERT-BOX ERROR.
        END.
    END.
    ELSE DO:
        MESSAGE "Product not found" VIEW-AS ALERT-BOX ERROR.
    END.
END.
END PROCEDURE. */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE totalprice wWin
PROCEDURE totalprice :
/*------------------------------------------------------------------------------
  Purpose:
  Parameters:  <none>
  Notes:
------------------------------------------------------------------------------*/
DO WITH FRAME FRAME-H:

    temp-quant = INTEGER(QUANTITY-SOLD-FILL:SCREEN-VALUE) NO-ERROR.
    temp-price = DECIMAL(PRICE-FILL:SCREEN-VALUE) NO-ERROR.

    temp-total = temp-quant * temp-price.

    TOTALPR-FILL:SCREEN-VALUE = STRING(temp-total).

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

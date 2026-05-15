/* salesData.p - Data Access Layer for Sales */
{data/ttDefinitions.i}

DEFINE INPUT  PARAMETER TABLE FOR ttSalesHeader.
DEFINE INPUT  PARAMETER TABLE FOR ttSalesDetail.
DEFINE OUTPUT PARAMETER oplSuccess AS LOGICAL NO-UNDO.

oplSuccess = FALSE.

DO TRANSACTION:
    DEFINE VARIABLE vInvoiceId AS INTEGER NO-UNDO.

    FIND FIRST ttSalesHeader NO-ERROR.
    IF AVAILABLE ttSalesHeader THEN DO:
        vInvoiceId = NEXT-VALUE(invoice_seq).

        CREATE SalesHeader.
        ASSIGN
            SalesHeader.invoiceId   = vInvoiceId
            SalesHeader.customerId  = ttSalesHeader.customerId
            SalesHeader.date        = ttSalesHeader.date
            SalesHeader.totalAmount = ttSalesHeader.totalAmount
            SalesHeader.taxAmount   = ttSalesHeader.taxAmount
            SalesHeader.netAmount   = ttSalesHeader.netAmount.

        ASSIGN ttSalesHeader.invoiceId = vInvoiceId. /* Return ID */
    END.

    IF vInvoiceId = 0 THEN RETURN.

    FOR EACH ttSalesDetail:
        CREATE SalesDetail.
        ASSIGN
            SalesDetail.salesDetailId = NEXT-VALUE(salesdetail_seq)
            SalesDetail.invoiceId     = vInvoiceId
            SalesDetail.productId     = ttSalesDetail.productId
            SalesDetail.quantity      = ttSalesDetail.quantity
            SalesDetail.price         = ttSalesDetail.price.

        /* Atomic Inventory Update & Stock Movement Log */
        FIND FIRST ProductMaster EXCLUSIVE-LOCK
             WHERE ProductMaster.productid = ttSalesDetail.productId NO-ERROR.
        IF AVAILABLE ProductMaster THEN DO:
            ProductMaster.stockquantity = ProductMaster.stockquantity - ttSalesDetail.quantity.

            CREATE StockMovement.
            ASSIGN
                StockMovement.movementId  = NEXT-VALUE(movement_seq)
                StockMovement.productId   = ttSalesDetail.productId
                StockMovement.type        = "SALE"
                StockMovement.quantity    = ttSalesDetail.quantity
                StockMovement.date        = TODAY
                StockMovement.referenceId = vInvoiceId.
        END.
    END.

    oplSuccess = TRUE.
END.

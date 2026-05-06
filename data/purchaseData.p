/* purchaseData.p - Data Access Layer for Purchases */
{data/ttDefinitions.i}

DEFINE INPUT  PARAMETER TABLE FOR ttPurchaseHeader.
DEFINE INPUT  PARAMETER TABLE FOR ttPurchaseDetail.
DEFINE OUTPUT PARAMETER oplSuccess AS LOGICAL NO-UNDO.

oplSuccess = FALSE.

DO TRANSACTION:
    DEFINE VARIABLE vPurchaseId AS INTEGER NO-UNDO.

    FOR EACH ttPurchaseHeader:
        vPurchaseId = NEXT-VALUE(purchase_seq).

        CREATE PurchaseHeader.
        ASSIGN
            PurchaseHeader.purchaseId  = vPurchaseId
            PurchaseHeader.supplierId  = ttPurchaseHeader.supplierId
            PurchaseHeader.date        = ttPurchaseHeader.date
            PurchaseHeader.totalAmount = ttPurchaseHeader.totalAmount.

        ASSIGN ttPurchaseHeader.purchaseId = vPurchaseId. /* Return ID */
    END.

    FOR EACH ttPurchaseDetail:
        CREATE PurchaseDetail.
        ASSIGN
            PurchaseDetail.purchaseDetailId = NEXT-VALUE(purchase_seq) /* Assuming same seq for details for demo, or could use its own */
            PurchaseDetail.purchaseId = vPurchaseId /* FK Linkage */
            PurchaseDetail.productId  = ttPurchaseDetail.productId
            PurchaseDetail.quantity   = ttPurchaseDetail.quantity
            PurchaseDetail.costPrice  = ttPurchaseDetail.costPrice.

        /* Atomic Inventory Update & Stock Movement Log */
        FIND FIRST ProductMaster EXCLUSIVE-LOCK
             WHERE ProductMaster.productid = ttPurchaseDetail.productId NO-ERROR.
        IF AVAILABLE ProductMaster THEN DO:
            ProductMaster.stockquantity = ProductMaster.stockquantity + ttPurchaseDetail.quantity.

            CREATE StockMovement.
            ASSIGN
                StockMovement.movementId  = NEXT-VALUE(movement_seq)
                StockMovement.productId   = ttPurchaseDetail.productId
                StockMovement.type        = "PURCHASE"
                StockMovement.quantity    = ttPurchaseDetail.quantity
                StockMovement.date        = TODAY
                StockMovement.referenceId = vPurchaseId.
        END.
    END.

    oplSuccess = TRUE.
END.

/* inventoryData.p - Data Access Layer for Inventory / Products */
{data/ttDefinitions.i}

DEFINE INPUT  PARAMETER ipiProductId AS INTEGER NO-UNDO.
DEFINE INPUT  PARAMETER ipiQuantity  AS INTEGER NO-UNDO.
DEFINE INPUT  PARAMETER ipcType      AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER ipiRefId     AS INTEGER NO-UNDO.

DO TRANSACTION:
    FIND FIRST ProductMaster EXCLUSIVE-LOCK
        WHERE ProductMaster.productid = ipiProductId NO-ERROR.

    IF AVAILABLE ProductMaster THEN DO:
        IF ipcType = "SALE" THEN
            ProductMaster.stockquantity = ProductMaster.stockquantity - ipiQuantity.
        ELSE IF ipcType = "PURCHASE" THEN
            ProductMaster.stockquantity = ProductMaster.stockquantity + ipiQuantity.

        CREATE StockMovement.
        ASSIGN
            StockMovement.movementId  = NEXT-VALUE(movement_seq)
            StockMovement.productId   = ipiProductId
            StockMovement.type        = ipcType
            StockMovement.quantity    = ipiQuantity
            StockMovement.date        = TODAY
            StockMovement.referenceId = ipiRefId.
    END.
END.

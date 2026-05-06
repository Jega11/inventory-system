/* productDataRetrieval.p - Data Access Layer for retrieving Products */
{data/ttDefinitions.i}

DEFINE INPUT  PARAMETER ipiProductId AS INTEGER NO-UNDO.
DEFINE OUTPUT PARAMETER TABLE FOR ttProduct.

EMPTY TEMP-TABLE ttProduct.

IF ipiProductId = 0 THEN DO:
    /* Get All */
    FOR EACH ProductMaster NO-LOCK:
        CREATE ttProduct.
        ASSIGN
            ttProduct.productId     = ProductMaster.productId
            ttProduct.productName   = ProductMaster.productName
            ttProduct.category      = ProductMaster.category
            ttProduct.price         = ProductMaster.price
            ttProduct.stockQuantity = ProductMaster.stockquantity.
    END.
END.
ELSE DO:
    /* Get By ID */
    FIND FIRST ProductMaster NO-LOCK
         WHERE ProductMaster.productid = ipiProductId NO-ERROR.

    IF AVAILABLE ProductMaster THEN DO:
        CREATE ttProduct.
        ASSIGN
            ttProduct.productId     = ProductMaster.productId
            ttProduct.productName   = ProductMaster.productName
            ttProduct.category      = ProductMaster.category
            ttProduct.price         = ProductMaster.price
            ttProduct.stockQuantity = ProductMaster.stockquantity.
    END.
END.

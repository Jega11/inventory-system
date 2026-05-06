/* productData.p - Data Access Layer for Products */
{data/ttDefinitions.i}

DEFINE INPUT  PARAMETER TABLE FOR ttProduct.
DEFINE OUTPUT PARAMETER oplSuccess AS LOGICAL NO-UNDO.

oplSuccess = FALSE.

DO TRANSACTION:
    FOR EACH ttProduct:
        /* Basic Upsert Logic */
        FIND FIRST ProductMaster EXCLUSIVE-LOCK
            WHERE ProductMaster.productid = ttProduct.productId NO-ERROR.

        IF NOT AVAILABLE ProductMaster THEN DO:
            CREATE ProductMaster.
            ProductMaster.productid = ttProduct.productId.
        END.

        ASSIGN
            ProductMaster.productname   = ttProduct.productName
            ProductMaster.category      = ttProduct.category
            ProductMaster.price         = ttProduct.price
            ProductMaster.stockquantity = ttProduct.stockQuantity.
    END.

    oplSuccess = TRUE.
END.

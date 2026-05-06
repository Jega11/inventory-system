/* ProductService.cls - Business logic for Products */
CLASS business.ProductService:
    {data/ttDefinitions.i}

    METHOD PUBLIC LOGICAL SaveProduct(INPUT TABLE ttProduct):
        DEFINE VARIABLE lSuccess AS LOGICAL NO-UNDO INITIAL FALSE.

        /* Validation */
        FIND FIRST ttProduct NO-ERROR.
        IF NOT AVAILABLE ttProduct OR ttProduct.productName = "" OR ttProduct.price < 0 THEN
            RETURN FALSE.

        /* Call Data Layer */
        RUN data/productData.p (INPUT TABLE ttProduct, OUTPUT lSuccess).

        RETURN lSuccess.
    END METHOD.

    METHOD PUBLIC VOID GetAllProducts(OUTPUT TABLE ttProduct):
        RUN data/productDataRetrieval.p (INPUT 0, OUTPUT TABLE ttProduct).
    END METHOD.

    METHOD PUBLIC VOID GetProductById(INPUT piProductId AS INTEGER, OUTPUT TABLE ttProduct):
        RUN data/productDataRetrieval.p (INPUT piProductId, OUTPUT TABLE ttProduct).
    END METHOD.

END CLASS.

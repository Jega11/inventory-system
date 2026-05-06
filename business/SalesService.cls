/* SalesService.cls - Business logic for Sales */
CLASS business.SalesService:
    {data/ttDefinitions.i}

    METHOD PUBLIC LOGICAL CreateSale(INPUT TABLE ttSalesHeader, INPUT TABLE ttSalesDetail):
        DEFINE VARIABLE lSuccess AS LOGICAL NO-UNDO INITIAL FALSE.

        /* Validation logic */
        FIND FIRST ttSalesHeader NO-ERROR.
        IF NOT AVAILABLE ttSalesHeader OR ttSalesHeader.totalAmount <= 0 THEN
            RETURN FALSE.

        /* Stock and Quantity Validation utilizing ProductService */
        DEFINE VARIABLE oProductService AS CLASS business.ProductService NO-UNDO.
        oProductService = NEW business.ProductService().

        FOR EACH ttSalesDetail:
            IF ttSalesDetail.quantity <= 0 THEN RETURN FALSE.

            EMPTY TEMP-TABLE ttProduct.
            oProductService:GetProductById(INPUT ttSalesDetail.productId, OUTPUT TABLE ttProduct).

            FIND FIRST ttProduct NO-ERROR.
            IF NOT AVAILABLE ttProduct OR ttSalesDetail.quantity > ttProduct.stockQuantity THEN
                RETURN FALSE.
        END.

        /* Call Data Layer (Atomic transaction handled internally) */
        RUN data/salesData.p (INPUT TABLE ttSalesHeader, INPUT TABLE ttSalesDetail, OUTPUT lSuccess).

        RETURN lSuccess.
    END METHOD.

END CLASS.

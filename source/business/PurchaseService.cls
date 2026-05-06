/* PurchaseService.cls - Business logic for Purchases */
CLASS business.PurchaseService:
    {data/ttDefinitions.i}

    METHOD PUBLIC LOGICAL CreatePurchase(INPUT TABLE ttPurchaseHeader, INPUT TABLE ttPurchaseDetail):
        DEFINE VARIABLE lSuccess AS LOGICAL NO-UNDO INITIAL FALSE.

        /* Validation */
        FIND FIRST ttPurchaseHeader NO-ERROR.
        IF NOT AVAILABLE ttPurchaseHeader OR ttPurchaseHeader.totalAmount <= 0 THEN
            RETURN FALSE.

        /* Call Data Layer (Atomic transaction handled internally) */
        RUN data/purchaseData.p (INPUT TABLE ttPurchaseHeader, INPUT TABLE ttPurchaseDetail, OUTPUT lSuccess).

        RETURN lSuccess.
    END METHOD.

END CLASS.

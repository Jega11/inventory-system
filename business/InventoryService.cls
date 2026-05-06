/* InventoryService.cls - Business logic for Inventory Management */
CLASS business.InventoryService:
    {data/ttDefinitions.i}

    METHOD PUBLIC VOID ReduceStock(INPUT piProductId AS INTEGER, INPUT piQty AS INTEGER, INPUT piRefId AS INTEGER):
        RUN data/inventoryData.p (INPUT piProductId, INPUT piQty, INPUT "SALE", INPUT piRefId).
    END METHOD.

    METHOD PUBLIC VOID IncreaseStock(INPUT piProductId AS INTEGER, INPUT piQty AS INTEGER, INPUT piRefId AS INTEGER):
        RUN data/inventoryData.p (INPUT piProductId, INPUT piQty, INPUT "PURCHASE", INPUT piRefId).
    END METHOD.

END CLASS.

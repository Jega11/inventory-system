/* ttDefinitions.i - Temp-Table Definitions for Data Exchange */

DEFINE TEMP-TABLE ttProduct NO-UNDO
    FIELD productId     AS INTEGER
    FIELD productName   AS CHARACTER
    FIELD category      AS CHARACTER
    FIELD price         AS DECIMAL
    FIELD stockQuantity AS INTEGER.

DEFINE TEMP-TABLE ttCustomer NO-UNDO
    FIELD customerId  AS INTEGER
    FIELD name        AS CHARACTER
    FIELD phone       AS CHARACTER
    FIELD email       AS CHARACTER
    FIELD address     AS CHARACTER
    FIELD creditLimit AS DECIMAL.

DEFINE TEMP-TABLE ttSupplier NO-UNDO
    FIELD supplierId  AS INTEGER
    FIELD name        AS CHARACTER
    FIELD phone       AS CHARACTER
    FIELD address     AS CHARACTER.

DEFINE TEMP-TABLE ttSalesHeader NO-UNDO
    FIELD invoiceId   AS INTEGER
    FIELD customerId  AS INTEGER
    FIELD date        AS DATE
    FIELD totalAmount AS DECIMAL
    FIELD taxAmount   AS DECIMAL
    FIELD netAmount   AS DECIMAL.

DEFINE TEMP-TABLE ttSalesDetail NO-UNDO
    FIELD salesDetailId AS INTEGER
    FIELD invoiceId     AS INTEGER
    FIELD productId     AS INTEGER
    FIELD quantity      AS INTEGER
    FIELD price         AS DECIMAL.

DEFINE TEMP-TABLE ttPurchaseHeader NO-UNDO
    FIELD purchaseId  AS INTEGER
    FIELD supplierId  AS INTEGER
    FIELD date        AS DATE
    FIELD totalAmount AS DECIMAL.

DEFINE TEMP-TABLE ttPurchaseDetail NO-UNDO
    FIELD purchaseDetailId AS INTEGER
    FIELD purchaseId       AS INTEGER
    FIELD productId        AS INTEGER
    FIELD quantity         AS INTEGER
    FIELD costPrice        AS DECIMAL.

DEFINE TEMP-TABLE ttUser NO-UNDO
    FIELD retailuserid AS INTEGER
    FIELD username     AS CHARACTER
    FIELD roleName     AS CHARACTER
    FIELD islocked     AS LOGICAL
    FIELD attempts     AS INTEGER.

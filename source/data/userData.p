/* userData.p - Data Access Layer for Users */
{data/ttDefinitions.i}

DEFINE INPUT  PARAMETER ipcUsername AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER ipcPassword AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER oplSuccess  AS LOGICAL NO-UNDO.
DEFINE OUTPUT PARAMETER TABLE FOR ttUser.

EMPTY TEMP-TABLE ttUser.
oplSuccess = FALSE.

DO TRANSACTION:
    FIND FIRST retailuser EXCLUSIVE-LOCK
        WHERE retailuser.username = ipcUsername NO-ERROR.

    IF AVAILABLE retailuser THEN DO:
        IF NOT retailuser.islocked AND retailuser.password = ipcPassword THEN DO:
            /* Success - reset attempts */
            ASSIGN
                retailuser.attempts = 0
                retailuser.islocked = FALSE
                oplSuccess = TRUE.
        END.
        ELSE DO:
            /* Failure - increment attempts */
            ASSIGN retailuser.attempts = retailuser.attempts + 1.

            IF retailuser.attempts >= 3 THEN DO:
                ASSIGN retailuser.islocked = TRUE.
            END.
        END.

        /* Get User Role */
        DEFINE VARIABLE cRoleName AS CHARACTER NO-UNDO INITIAL "Unknown".
        FIND FIRST UserRoleMapping NO-LOCK
             WHERE UserRoleMapping.usrId = retailuser.retailuserid NO-ERROR.
        IF AVAILABLE UserRoleMapping THEN DO:
             FIND FIRST Role NO-LOCK
                  WHERE Role.roleId = UserRoleMapping.roleId NO-ERROR.
             IF AVAILABLE Role THEN
                  cRoleName = Role.roleName.
        END.

        /* Always return user info so caller knows if locked */
        CREATE ttUser.
        ASSIGN
            ttUser.retailuserid = retailuser.retailuserid
            ttUser.username     = retailuser.username
            ttUser.roleName     = cRoleName
            ttUser.islocked     = retailuser.islocked
            ttUser.attempts     = retailuser.attempts.
    END.
END.

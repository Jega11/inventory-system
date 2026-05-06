/* UserService.cls - Business logic for user authentication and management */
CLASS business.UserService:
    {data/ttDefinitions.i}

    METHOD PUBLIC LOGICAL AuthenticateUser(INPUT ipcUsername AS CHARACTER, INPUT ipcPassword AS CHARACTER, OUTPUT TABLE ttUser):
        DEFINE VARIABLE lSuccess AS LOGICAL NO-UNDO INITIAL FALSE.

        RUN data/userData.p (INPUT ipcUsername, INPUT ipcPassword, OUTPUT lSuccess, OUTPUT TABLE ttUser).

        FIND FIRST ttUser NO-ERROR.
        IF AVAILABLE ttUser THEN DO:
            /* If the user is locked out, fail authentication regardless of password match.
               The data tier has updated the DB, so we just check the ttUser returned. */
            IF ttUser.islocked = TRUE THEN DO:
                RETURN FALSE.
            END.
        END.

        RETURN lSuccess.
    END METHOD.

END CLASS.

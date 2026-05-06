# Retail Inventory and Sales Management System - Codebase Analysis

## 1. Overview
The **Retail Inventory and Sales Management System** is a desktop application designed for standard Windows environments. It simplifies retail operations by providing tools for both administrators (inventory management and sales reporting) and sales staff (sales data entry).

The system uses a two-tier client-server architecture built entirely using the Progress Software Corporation suite of tools (OpenEdge ABL).

## 2. Technology Stack
*   **Programming Language:** Progress 4GL / OpenEdge ABL (version 12.8)
*   **Database:** Progress OpenEdge RDBMS (Relational Database Management System)
*   **User Interface:** Progress AppBuilder (GUI application using `.w` files)

## 3. System Architecture
The application follows a traditional two-tier architecture:

### 3.1. Client Tier (User Interface)
*   Runs locally on the desktop of end-users.
*   Responsible for presenting the GUI and executing the business logic.
*   Constructed using AppBuilder widgets like FRAMES, BROWSE tables, FILL-IN fields, and BUTTONS.
*   The `.w` (Window) files contain both the UI layout definitions and the Progress 4GL business logic.

### 3.2. Server Tier (Data Layer)
*   The business logic runs on the client-side but interacts closely with the backend database.
*   The backend is a multi-user Progress OpenEdge RDBMS (`retaildb`).
*   This setup allows multiple users to connect and interact with the database concurrently without data corruption.

## 4. Codebase Structure
*   `README.md`: Contains the project overview, setup, flow diagrams, and database schemas.
*   `Screens/`: Contains the UI screens built with Progress AppBuilder (`.w` files).
    *   `Loginscreen.w` / `Loginscreen(without images).w`: Handles user authentication and redirects to the appropriate dashboard based on roles (`isAdmin`).
    *   `master-screen.w` / `master-screen(without images).w`: Administrator dashboard.
    *   `Product-maintainence-screen.w`: Screen for managing inventory (`ProductMaster` table).
    *   `sales-entrey.w`: Screen for sales staff to input new sales.
    *   `salesreportscreen.w`: Screen for viewing sales reports.
*   `Tables/`: Contains database schema definitions and data logic.
    *   `retailuser/`: Defines the `retailuser` table.
    *   `ProductMaster/`: Defines the `ProductMaster` table.
    *   `SalesTransactions/`: Defines the `SalesTransaction` table.
*   `multiuserdatabase/`: Contains the actual database files (`retaildb.db`, `.d1`, etc.) for the multi-user OpenEdge database.
*   `images/`: Contains graphical assets used in the GUI screens.

## 5. Database Schema
The OpenEdge database (`retaildb`) has three primary tables:

### 5.1. `retailuser`
Manages application users, authentication, and roles.
*   **`retailuserid`** (Integer, Primary Key, Unique Index)
*   **`username`** (Character, Index)
*   **`isAdmin`** (Logical): Determines whether the user is an Administrator or Salesperson.
*   **`password`** (Character)
*   **`islocked`** (Logical): Used to lock out accounts after too many failed login attempts.
*   **`attempts`** (Integer): Tracks consecutive failed login attempts.

### 5.2. `ProductMaster`
Stores inventory information.
*   **`productid`** (Integer, Primary Key, Unique Index)
*   **`productname`** (Character, Index)
*   **`category`** (Character)
*   **`price`** (Integer)
*   **`stockquantity`** (Integer)

### 5.3. `SalesTransaction`
Records individual sales transactions.
*   **`transactionid`** (Integer, Primary Key, Unique Index)
*   **`transactiondate`** (Date)
*   **`productid`** (Integer, Index): References `ProductMaster.productid`.
*   **`quantitysold`** (Integer)
*   **`totalprice`** (Decimal, 3 decimals precision)

## 6. Business Logic Observations
*   **Authentication Flow:** In `Loginscreen.w`, the user inputs a username and password. The system queries the `retailuser` table. It tracks failed `attempts` and sets `islocked = TRUE` if failed attempts reach 3. If login is successful, `attempts` is reset to 0, and the user is routed to either `master-screen.w` (if `isAdmin = TRUE`) or `sales-entrey.w` (if `isAdmin = FALSE`).
*   **Transaction Handling:** Database interactions (such as the authentication query) use `DO TRANSACTION:` blocks combined with `EXCLUSIVE-LOCK` or other locking mechanisms to ensure data integrity in the multi-user environment.

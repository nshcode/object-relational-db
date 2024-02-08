DROP TYPE tag_tab_typ;
DROP TYPE tag_typ;
DROP TYPE product_typ;
DROP TYPE feature_typ; 
DROP TYPE bug_typ;
DROP TYPE comment_typ;
DROP TYPE issue_typ;
DROP TYPE account_typ;

-- ================
-- account
-- ================
CREATE OR REPLACE TYPE account_typ AS OBJECT (
    account_id    INTEGER
    ,account_name VARCHAR(20)
    ,email        VARCHAR(100)
);
/
-- ================
-- issue
-- ================
CREATE OR REPLACE TYPE issue_typ AS OBJECT (
    issue_id     INTEGER
    ,summary     VARCHAR(50)
    ,priority    VARCHAR(20)
    ,reported_by REF account_typ
    ,assigned_to REF account_typ
 ) NOT FINAL;
 /
 
 CREATE OR REPLACE TYPE bug_typ UNDER issue_typ (
    severity          VARCHAR(20)
    ,version_affected VARCHAR(20)
 );
 /
 
CREATE OR REPLACE TYPE feature_typ UNDER issue_typ (
    sponsor VARCHAR(20)
 );
 /
 
 -- ==================
-- comment
-- ==================
CREATE OR REPLACE TYPE comment_typ AS OBJECT (
    comment_id INTEGER
    ,text      VARCHAR(4000)
    ,issue     REF issue_typ
    ,author    REF account_typ
 );
 /
 
 -- ===============
-- product
-- ===============
CREATE OR REPLACE TYPE product_typ AS OBJECT (
    product_id    INTEGER
    ,product_name VARCHAR(50)
 );
 /
 
 -- ===================
-- Tags
-- ===================
CREATE OR REPLACE TYPE tag_typ AS OBJECT (
    tag VARCHAR(50)
);
/

CREATE OR REPLACE TYPE  tag_tab_typ AS TABLE OF tag_typ
/

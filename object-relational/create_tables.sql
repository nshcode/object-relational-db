DROP TABLE issue_tags;
DROP TABLE issues_products;
DROP TABLE products;
DROP TABLE comments;
DROP TABLE issues;
DROP TABLE accounts;

-- =====================
-- Accounts
-- =====================
CREATE TABLE accounts OF account_typ (
    PRIMARY KEY (account_id)
    ,UNIQUE (account_name)
);

-- ====================
-- Issues
-- ====================
CREATE TABLE issues OF issue_typ(
    PRIMARY KEY  (issue_id)
    ,FOREIGN KEY (reported_by) REFERENCES accounts
    ,FOREIGN KEY (assigned_to) REFERENCES accounts
    ,CHECK (priority IN ('High', 'Normal', 'Low'))
 );
 
-- ==================
-- Comments
-- ==================
CREATE TABLE comments OF comment_typ (
    PRIMARY KEY  (comment_id)
    ,FOREIGN KEY (issue)  REFERENCES issues
    ,FOREIGN KEY (author) REFERENCES accounts
 );
 
-- ===============
-- Products
-- ===============
CREATE TABLE products of product_typ (
     PRIMARY KEY (product_id)
    ,UNIQUE      (product_name)
 );

CREATE TABLE issues_products (
    issue      REF issue_typ
    ,product   REF product_typ
    ,status    VARCHAR(20)
    ,FOREIGN KEY (issue)     REFERENCES issues
    ,FOREIGN KEY (product)   REFERENCES products
    ,CHECK (status IN ('New'
                        ,'Assigned'
                        ,'In-Progress'
                        ,'Reviewing'
                        ,'Finished'
                    )
            )
 );
 

-- ===============
-- issue_tags
-- ===============
CREATE TABLE issue_tags (
    issue        REF issue_typ
    ,issue_tags  tag_tab_typ
    ,FOREIGN KEY (issue) REFERENCES issues
)
NESTED TABLE issue_tags STORE AS issue_tags_tab; 


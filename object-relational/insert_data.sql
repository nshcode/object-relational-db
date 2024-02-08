
-- =====================
-- Accounts
-- =====================
INSERT INTO accounts 
VALUES (account_typ(1, 'bob',   'bon@abc.com'));   
INSERT INTO accounts(account_id, account_name, email)
VALUES (2, 'alice', 'alice@abc.com');

-- ====================
-- Issues
-- ====================
INSERT INTO issues 
VALUES (
    bug_typ(1, 
        'crash when I save'
        ,'High'
        ,(SELECT REF(p) 
            FROM accounts p 
            WHERE account_name = 'bob'
        )
        , null
        ,'Critical'
        ,'1.0'
    )
);

INSERT INTO issues 
VALUES (feature_typ(2
            ,'increase performance', 'Normal'
            ,(SELECT REF(p) 
                FROM accounts p 
                WHERE account_name = 'alice'
            )
            ,null
            ,'xyz sponsor'
        )
);

-- ==================
-- Comments
-- ==================
INSERT INTO comments(comment_id, text, issue, author)
VALUES (1
    ,'a comment'
    ,(SELECT REF(s) 
        FROM issues s 
        WHERE s.issue_id = 1
    )
    ,(SELECT REF(p) 
        FROM accounts p  
        WHERE p.account_name = 'alice'
    )
 );

-- ===============
-- Products
-- ===============
INSERT INTO products
 VALUES (product_typ('1', 'Open RoundFile'));
 
INSERT INTO issues_products (issue, product, status)
VALUES (
        (SELECT REF(p) 
            FROM issues p 
            WHERE p.issue_id = 1
        )
        ,(SELECT REF(p) 
            FROM products p 
            WHERE p.product_id = 1
        )
        ,'New'
 );
 
-- ============
-- Issue_Tags
-- ============
INSERT INTO issue_tags (issue, issue_tags)
VALUES (
    (SELECT REF(P)
        FROM issues p 
        WHERE p.issue_id = 1
    )
    ,(
        tag_tab_typ(tag_typ('crash'), tag_typ('svae'))
    )
);

INSERT INTO issue_tags (issue, issue_tags)
VALUES (
    (SELECT REF(P)
        FROM issues p 
        WHERE p.issue_id = 2
    )
    ,(
        tag_tab_typ(tag_typ('performance'), tag_typ('new_idea'))
    )
);

-- ==============
-- Sample Queries
-- ==============

-- List all issues of the type "feature_typ".
SELECT * FROM issues p WHERE VALUE(p) IS OF (feature_typ)
;

-- Show all issues commented on by Alice.
SELECT
    DEREF (c.issue).issue_id
    ,DEREF (c.issue).summary
FROM comments c
WHERE DEREF (c.author).account_name = 'alice'
;

-- Show all products having bugs in the status "New".
SELECT 
    DEREF (ip.issue).summary
    ,DEREF (ip.product).product_name
FROM issues_products ip
WHERE ip.status = 'New'
    AND DEREF (ip.issue) IS OF (bug_typ)
;

-- List the content of the nested table using the THE() function.
SELECT t.tag
FROM THE (SELECT issue_tags
            FROM issue_tags s
            WHERE DEREF(s.issue).issue_id = 1
        ) t
;
        
-- Show each issue with the associated tags using the TABLE() function.
SELECT 
    DEREF(it.issue)
    ,t.tag
FROM issue_tags it
CROSS JOIN  TABLE(it.issue_tags) t
;
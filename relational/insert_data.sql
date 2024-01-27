-- ================
-- dummy data
-- ================

-- ==========
-- accounts
-- ==========
insert into accounts (account_id, account_name, email)
    values(1, 'bob', 'bob@abc.com');
insert into accounts (account_id, account_name, email)
    values(2, 'alice', 'alice@abc.com');

-- ==========
-- issues
-- ==========
insert into issues (issue_id, summary, priority, reported_by, kind)
    values (1, 'crash when I save', 'High', 1, 'Bug');
insert into issues (issue_id, summary, priority, reported_by, kind)
    values (2, 'increase performance', 'Normal', 2, 'Feature');

insert into bugs (issue_id, severity, version_affected, kind)
    values (1, 'Critical', '2.0', 'Bug');
    
insert into feature_requests (issue_id, sponsor, kind)
    values (2, 'XYZ', 'Feature');

-- ==========
-- status
-- ==========
insert into status(status_id, status)
    values (1, 'New');
insert into status(status_id, status)
    values (2, 'Assigned');
insert into status(status_id, status)
    values (3, 'In-Progress');
insert into status(status_id, status)
    values (4, 'Reviewing');
insert into status(status_id, status)
    values (5, 'Finished');        
    
-- ==========
-- products
-- ==========
insert into products(product_id, product_name)
    values (1, 'Word Processor');
insert into products(product_id, product_name)
    values (2, 'Visual TurboBuilder');

insert into issues_products (issue_id, product_id, status_id)
    values (1, 1, 1);
insert into issues_products (issue_id, product_id, status_id)
    values (2, 2, 1);

-- ==========
-- comments
-- ==========
insert into comments (comment_id, text, issue_id, author_id)
    values (1, 'It crashes!', 1, 1);
insert into comments (comment_id, text, issue_id, author_id)
    values (2, 'Great idea!', 2, 2);
 
insert into tags (issue_id, tag)
    values (1, 'crach');
insert into tags (issue_id, tag)
    values (1, 'save');
insert into tags (issue_id, tag)
    values (2, 'printting');    
insert into tags (issue_id, tag)
    values (2, 'performance');

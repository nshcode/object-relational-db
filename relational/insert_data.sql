
insert into accounts (account_id, account_name, email)
    values(1, 'bob', 'bob@abc.com');
insert into accounts (account_id, account_name, email)
    values(2, 'alice', 'alice@abc.com');

insert into issues (issue_id, status, priority, reported_by, kind)
    values (1, 'NEW', 'HIGH', 1, 'BUG');
insert into issues (issue_id, status, priority, reported_by, kind)
    values (2, 'NEW', 'NORMAL', 1, 'FEATURE');

insert into bugs (issue_id, severity, version_affected, kind)
    values (1, 'CRITICAL', '2.0', 'BUG');
    
insert into feature_requests (issue_id, sponsor, kind)
    values (2, 'XYZ', 'FEATURE');
    
insert into comments (comment_id, text, issue_id, author_id)
    values (1, 'It crashes!', 1, 1);
insert into comments (comment_id, text, issue_id, author_id)
    values (2, 'Great idea!', 2, 2);

 delete from tags;   
insert into tags (issue_id, tag)
    values (1, 'crach');
insert into tags (issue_id, tag)
    values (1, 'save');
insert into tags (issue_id, tag)
    values (2, 'printting');    
insert into tags (issue_id, tag)
    values (2, 'performance');
    
insert into products(product_id, product_name)
    values (1, 'Word Processor');
insert into products(product_id, product_name)
    values (2, 'Visual TurboBuilder');
    
insert into issues_products (issue_id, product_id)
    values (1, 1);
insert into issues_products (issue_id, product_id)
    values (2, 2);

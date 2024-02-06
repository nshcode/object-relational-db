-- ==================================================
-- Relational Version Of the issue-tracking Databas
-- ==================================================

create table accounts (
    account_id    integer
    ,account_name varchar(20)
    ,email        varchar(100)
    ,primary key(account_id)
    ,unique (account_name)
);

create table issues (
    issue_id     integer
    ,summary     varchar(20)
    ,priority    varchar(20) default 'Normal'
    ,reported_by integer
    ,assigned_to integer
    ,kind        varchar(10)
    ,primary key (issue_id)
    ,foreign key (reported_by) references accounts(account_id)
    ,foreign key (assigned_to) references accounts(account_id)
    ,check (priority in ('High', 'Normal', 'Low'))
    ,check (kind in ('Bug', 'Feature'))
);

create table bugs (
    issue_id          integer
    ,severity         varchar(20)
    ,version_affected varchar(20)
    ,kind             varchar(10) default 'Bug'
    ,primary key (issue_id)
    ,foreign key (issue_id) references issues(issue_id)
    ,check (kind in ('Bug'))
);

create table feature_requests (
    issue_id integer
    ,sponsor varchar(50)
    ,kind   varchar(10) default 'Feature'
    ,primary key (issue_id)
    ,foreign key (issue_id) references issues(issue_id)
    ,check (kind in ('Feature'))
);

create table comments (
    comment_id integer
    ,text      varchar(4000)
    ,issue_id  integer
    ,author_id integer
    ,primary key (comment_id)
    ,foreign key (issue_id)  references issues(issue_id)
    ,foreign key (author_id) references accounts(account_id) 
);

create table tags (
    issue_id integer
    ,tag     varchar(20)
    ,primary key (issue_id, tag)
    ,foreign key (issue_id) references issues(issue_id)
);

create table products (
    product_id    integer
    ,product_name varchar(50)
    ,primary key(product_id)
    ,unique (product_name)
);

create table status (
    status_id integer
    ,status   varchar(20) 
    ,primary key (status_id)
    ,unique(status)
    ,check (status in ('New'
                        ,'Assigned'
                        ,'In-Progress'
                        ,'Reviewing'
                        ,'Finished'
                    )
            )
);

create table issues_products (
    issue_id    integer
    ,product_id integer
    ,status_id  integer
    ,primary key (issue_id, status_id)
    ,foreign key (issue_id)   references issues (issue_id)
    ,foreign key (product_id) references products (product_id)
    ,foreign key (status_id)  references status (status_id)  
);

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

-- ==========
-- bugs
-- ==========
insert into bugs (issue_id, severity, version_affected, kind)
    values (1, 'Critical', '2.0', 'Bug');
 
-- ==================
-- feature_requests
-- ==================   
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

-- ==========
-- issues_products
-- ==========
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
 
-- ==========
-- tage
-- ==========
insert into tags (issue_id, tag)
    values (1, 'crach');
insert into tags (issue_id, tag)
    values (1, 'save');
insert into tags (issue_id, tag)
    values (2, 'printting');    
insert into tags (issue_id, tag)
    values (2, 'performance');


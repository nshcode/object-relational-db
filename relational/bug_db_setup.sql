-- ========================================
-- Relational Version Of the Bug Databas
-- ========================================

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
    ,primary key (issue_id, product_id, status_id)
    ,foreign key (issue_id)   references issues (issue_id)
    ,foreign key (product_id) references products (product_id)
    ,foreign key (status_id)  references status (status_id)  
);

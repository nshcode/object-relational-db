-- ========================================
-- Relational Version Of the Bug Databas
-- ========================================

drop table issues_products;
drop table products;
drop table tags;
drop table feature_requests;
drop table comments;
drop table bugs;
drop table issues;
drop table accounts;

create table accounts (
    account_id    integer
    ,account_name varchar(20)
    ,email        varchar(100)
    ,primary key(account_id)
    ,unique (account_name)
);

create table issues (
    issue_id     integer
    ,status      varchar(20) default 'NEW'
    ,priority    varchar(20)
    ,reported_by integer
    ,assigned_to integer
    ,kind        varchar(10)
    ,primary key (issue_id)
    ,foreign key (reported_by) references accounts(account_id)
    ,foreign key (assigned_to) references accounts(account_id)
    ,check (status in ('NEW', 'ASSIGNED', 'IN PROCESS', 'FINISHED'))
    ,check (kind in ('BUG', 'FEATURE'))
);

create table bugs (
    issue_id          integer
    ,severity         varchar(20)
    ,version_affected varchar(20)
    ,kind             varchar(10) default 'BUG'
    ,primary key (issue_id)
    ,foreign key (issue_id) references issues(issue_id)
    ,check (kind in ('BUG'))
);

create table feature_requests (
    issue_id integer
    ,sponsor varchar(50)
    ,kind   varchar(10) default 'FEATURE'
    ,primary key (issue_id)
    ,foreign key (issue_id) references issues(issue_id)
    ,check (kind in ('FEATURE'))
);


create table comments (
    comment_id integer
    ,text      varchar(4000)
    ,issue_id  integer
    ,author_id integer
    ,primary key (comment_id)
    ,foreign key (issue_id) references issues(issue_id)
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
);

create table issues_products (
    issue_id    integer
    ,product_id integer
    ,primary key (issue_id, product_id)
    ,foreign key (issue_id) references issues (issue_id)
    ,foreign key (product_id) references products (product_id)
);

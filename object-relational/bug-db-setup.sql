drop table issues_products;
drop table products;
drop table issues;
drop table comments;
drop table accounts;

drop type tag_tab_typ;
drop type product_typ;
drop type feature_typ; 
drop type bug_typ;
drop type comment_typ;
drop type issue_typ;
drop type account_typ;

-- =====================
-- Accounts
-- =====================
create or replace type account_typ as object (
    account_id    integer
    ,account_name varchar(20)
    ,email        varchar(100)
);
/

create table accounts of account_typ (
    primary key (account_id)
    ,unique (account_name)
);

-- Method 1
insert into accounts 
    values (account_typ(1, 'bob',   'bon@abc.com'));
-- Method 2   
insert into accounts(account_id, account_name, email)
    values (2, 'alice', 'alice@abc.com');

select account_id, account_name, email from accounts;
select value(a) from accounts a;

update accounts 
set    email = 'alice@abc.org'
where  account_name = 'alice';

delete from accounts where account_name = 'alice';

-- ====================
-- Issues
-- ====================

create type issue_typ as object (
    issue_id     integer
    ,suammry     varchar(20)
    ,priority    varchar(20)
    ,reported_by ref account_typ
    ,assigned_to ref account_typ
 ) not final;
 /
 
 create table issues of issue_typ(
    primary key (issue_id)
    ,foreign key (reported_by) references accounts
    ,foreign key (assigned_to) references accounts
 );

create type bug_typ under issue_typ (
    severity          varchar(20)
    ,version_affected varchar(20)
 );
 /
 
 create type feature_typ under issue_typ (
    sponsor varchar(50)
 );
 /
 
 insert into issues 
    values (
        bug_typ(1, 
                'crash when I save'
                ,'HIGH'
                ,(select ref(p) from accounts p where account_name = 'bob')
                , null
                ,'CRITICAL'
                ,'1.0'
            )
    );

insert into issues 
    values (
        feature_typ(2
                    ,'increase performance', 'NORMAL'
                    ,(select ref(p) from accounts p where account_name = 'alice')
                    ,null
                    ,'xyz sponsor'
            )
    );

select * from issues p where value(p) is of (bug_typ);


-- ==================
-- Comments
-- ==================
create or replace type comment_typ as object (
    comment_id integer
    ,text      varchar(4000)
    ,issue     ref issue_typ
    ,author    ref account_typ
 );
 /
 
 create table comments of comment_typ (
    primary key (comment_id)
    ,foreign key (issue) references issues
    ,foreign key (author) references accounts
 );
 
 insert into comments(comment_id, text, issue, author)
 values (
    1
    ,'a comment'
    ,(select ref(p) from issues p where issue_id = 1)
    ,(select ref(p) from accounts p where p.account_name = 'alice')
 );
 
 delete from comments;
 select * from comments;
 
-- ===============
-- Products
-- ===============

create type product_typ as object (
    product_id    number
    ,product_name varchar(50)
 );
 /
 
 create table products of product_typ (
    primary key(product_id)
 );
 
 create table issues_products (
    issue    ref issue_typ
    ,product ref product_typ
 );
 
 insert into products 
 values (product_typ('1', 'Open RoundFile'));
 
 insert into issues_products 
 values (
        (select ref(p) from issues p where p.issue_id = 1)
        ,(select ref(p) from products p where p.product_id = 1)
    );
    
select deref(p.issue), deref(p.product) from issues_products p;
select deref(p.issue).issue_id, deref(p.product).product_name from issues_products p;
drop table issues_products;
drop table status;
drop table products;
drop table comments;
drop table issues;
drop table accounts;

-- drop type tag_typ;
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

delete from accounts;
-- Method 1
INSERT INTO accounts 
VALUES (account_typ(1, 'bob',   'bon@abc.com'));

-- Method 2   
INSERT INTO accounts(account_id, account_name, email)
VALUES (2, 'alice', 'alice@abc.com');

-- Method 1
SELECT account_id, account_name, email FROM accounts;

-- Method 2
SELECT  VALUE(a) FROM accounts a;

update accounts 
set    email = 'alice@abc.org'
where  account_name = 'alice';

delete from accounts where account_name = 'alice';

-- ====================
-- Issues
-- ====================

create type issue_typ as object (
    issue_id     integer
    ,summary     varchar(20)
    ,priority    varchar(20)
    ,reported_by ref account_typ
    ,assigned_to ref account_typ
 ) not final;
 /
 
 create table issues of issue_typ(
    primary key (issue_id)
    ,foreign key (reported_by) references accounts
    ,foreign key (assigned_to) references accounts
    ,check (priority in ('High', 'Normal', 'Low'))
 );
 
-- ===================
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
    ,unique (product_name)
 );
 
 
 create table issues_products (
    issue      ref issue_typ
    ,product   ref product_typ
    ,status    varchar(20)
    ,foreign key (issue)     references issues
    ,foreign key (product)   references products
    ,check (status in ('New'
                        ,'Assigned'
                        ,'In-Progress'
                        ,'Reviewing'
                        ,'Finished'
                    )
            )
 );

-- ====================
create type bug_typ under issue_typ (
    severity          varchar(20)
    ,version_affected varchar(20)
 );
 /
 
 create type feature_typ under issue_typ (
    sponsor varchar(50)
 );
 /
 -- =============================
 -- Data
 -- ==============================
 
insert into issues 
values (
    bug_typ(1, 
        'crash when I save'
        ,'High'
        ,(select ref(p) 
            from accounts p 
            where account_name = 'bob'
        )
        , null
        ,'Critical'
        ,'1.0'
    )
);

insert into issues 
values (feature_typ(2
            ,'increase performance', 'Normal'
            ,(select ref(p) 
                from accounts p 
                where account_name = 'alice'
            )
            ,null
            ,'xyz sponsor'
        )
);

select * from issues p where value(p) is of (bug_typ);
 
 insert into comments(comment_id, text, issue, author)
 values (1
    ,'a comment'
    ,(select ref(p) from issues p where issue_id = 1)
    ,(select ref(p) 
        from accounts p 
        where p.account_name = 'alice'
    )
 );
 
 delete from comments;
 select * from comments;
 
 
 insert into products 
 values (product_typ('1', 'Open RoundFile'));
 
 insert into issues_products 
 values (
        (select ref(p) from issues p where p.issue_id = 1)
        ,(select ref(p) from products p where p.product_id = 1)
    );
    
select deref(p.issue), deref(p.product) from issues_products p;
select deref(p.issue).issue_id, deref(p.product).product_name from issues_products p;

-- ===================
-- Tags
-- ===================

drop table issues_products;
drop table issues;

create type tag_typ as object (
    tag varchar(50)
);
/
drop type tag_tab_typ;
create type tag_tab_typ as table of tag_typ
/

create table issues (
    issue issue_typ
    ,issue_tags tag_tab_typ
    ,primary key (issue.issue_id)
)
nested table issue_tags store as issue_tags_tab; 

INSERT INTO issues (issue)
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

UPDATE issues 
SET issue_tags = tag_tab_typ(tag_typ('crash'), tag_typ('svae'));

select 
    * 
from (select issue from issues) x;


SELECT t.tag
FROM THE (SELECT issue_tags
            FROM issues s
            WHERE   s.issue.issue_id = 1
        ) t;
        
select 
    *
from issues s
join table (issues.issue_tags) t
    on issues
;

\c bank_transactions

drop table if exists account cascade;

create table account (
    username varchar(64) not null,
    fullname varchar(64) not null,
    balance int not null,
    group_id_ int not null
);

insert into account values ('jones', 'Alice Jones', 82, 1);
insert into account values ('bitdiddl', 'Ben Bitdiddle', 65, 1);
insert into account values ('mike', 'Michael Dole', 73, 2);
insert into account values ('alyssa', 'Alyssa P. Hacker', 79, 3);
insert into account values ('bbrown', 'Bob Brown', 100, 3);

\c bank_transactions

drop table account;

create table account (
    id serial primary key,
    name varchar(64),
    credit int,
    currency varchar(3)
);


insert into account (name, credit, currency) values
    ('Account 1', 1000, 'RUB'),
    ('Account 2', 1000, 'RUB'),
    ('Account 3', 1000, 'RUB');

begin;
    update account set credit=(select credit from account where name='Account 1') - 500 where name = 'Account 1';
    update account set credit=(select credit from account where name='Account 3') + 500 where name = 'Account 3';

    update account set credit=(select credit from account where name='Account 2') - 700 where name = 'Account 2';
    update account set credit=(select credit from account where name='Account 1') + 700 where name = 'Account 1';

    update account set credit=(select credit from account where name='Account 2') - 100 where name = 'Account 2';
    update account set credit=(select credit from account where name='Account 3') + 100 where name = 'Account 3';
    select * from account;
rollback;
select * from account;

\c bank_transactions

drop table account;

create table account (
    id serial primary key,
    name varchar(64),
    credit int,
    currency varchar(3),
    bank_name varchar(64)
);


insert into account (name, credit, currency, bank_name) values
    ('Account 1', 1000, 'RUB', 'SberBank'),
    ('Account 2', 1000, 'RUB', 'Tinkoff'),
    ('Account 3', 1000, 'RUB', 'SberBank'),
    ('Account 4', 0, 'RUB', 'Worldwide-no-fee-bank');


begin;
    update account set credit=(select credit from account where name='Account 1') - 500 where name = 'Account 1';
    update account set credit=(select credit from account where name='Account 3') + 500 where name = 'Account 3';
    update account set credit=(select credit from account where name='Account 4') + 0 where name = 'Account 4';

    update account set credit=(select credit from account where name='Account 2') - 730 where name = 'Account 2';
    update account set credit=(select credit from account where name='Account 1') + 700 where name = 'Account 1';
    update account set credit=(select credit from account where name='Account 4') + 30 where name = 'Account 4';

    update account set credit=(select credit from account where name='Account 2') - 130 where name = 'Account 2';
    update account set credit=(select credit from account where name='Account 3') + 100 where name = 'Account 3';
    update account set credit=(select credit from account where name='Account 4') + 30 where name = 'Account 4';
    select * from account;
rollback;
select * from account;

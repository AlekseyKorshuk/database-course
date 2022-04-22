\c bank_transactions

drop table if exists account cascade;
drop table if exists ledger cascade;

create table if not exists account (
    id serial primary key,
    name varchar(64),
    credit int,
    currency varchar(3),
    bank_name varchar(64)
);


create table if not exists ledger (
    id serial primary key,
    source_account int not null ,
    destination_account int not null,
    fee int not null,
    amount int not null check (amount > 0),
    ts timestamp,
    foreign key (source_account) references account(id) on delete cascade,
    foreign key (destination_account) references account(id) on delete cascade
);


insert into account (name, credit, currency, bank_name) values
    ('Account 1', 1000, 'RUB', 'SberBank'),
    ('Account 2', 1000, 'RUB', 'Tinkoff'),
    ('Account 3', 1000, 'RUB', 'SberBank'),
    ('Account 4', 0, 'RUB', 'Worldwide-fee-collector');


begin;
    update account set credit=(select credit from account where name='Account 1') - 500 where name = 'Account 1';
    update account set credit=(select credit from account where name='Account 3') + 500 where name = 'Account 3';
    update account set credit=(select credit from account where name='Account 4') + 0 where name = 'Account 4';
    insert into ledger (source_account, destination_account, fee, amount, ts) values (
        (select id from account where name = 'Account 1'),
        (select id from account where name = 'Account 3'),
        0,
        500,
        clock_timestamp()
    );
    select pg_sleep(0.1);

    update account set credit=(select credit from account where name='Account 2') - 730 where name = 'Account 2';
    update account set credit=(select credit from account where name='Account 1') + 700 where name = 'Account 1';
    update account set credit=(select credit from account where name='Account 4') + 30 where name = 'Account 4';
    insert into ledger (source_account, destination_account, fee, amount, ts) values (
        (select id from account where name = 'Account 2'),
        (select id from account where name = 'Account 1'),
        30,
        700,
        clock_timestamp()
    );
    select pg_sleep(0.1);

    update account set credit=(select credit from account where name='Account 2') - 130 where name = 'Account 2';
    update account set credit=(select credit from account where name='Account 3') + 100 where name = 'Account 3';
    update account set credit=(select credit from account where name='Account 4') + 30 where name = 'Account 4';
    insert into ledger (source_account, destination_account, fee, amount, ts) values (
        (select id from account where name = 'Account 2'),
        (select id from account where name = 'Account 3'),
        30,
        700,
        clock_timestamp()
    );

    select * from account;
    select * from ledger;
rollback;
select * from account;
select * from ledger;

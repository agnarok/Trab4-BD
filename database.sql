create table products
(
    id        integer,
    asin      varchar not null
        constraint products_pk
            primary key,
    title     varchar,
    "group"   varchar,
    salesrank integer
);

alter table products
    owner to postgres;

create unique index products_asin_uindex
    on products (asin);

create table similars
(
    asin_1 varchar not null
        constraint similars_products_asin_fk
            references products,
    asin_2 varchar
);

alter table similars
    owner to postgres;
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

create table categories
(
    id   integer not null
        constraint categories_pk
            primary key,
    name varchar
);

alter table categories
    owner to postgres;

create table product_category
(
    product_asin varchar
        constraint product_category_products_asin_fk
            references products,
    category_id  integer
        constraint product_category_categories_id_fk
            references categories
);

alter table product_category
    owner to postgres;

create unique index product_category_product_asin_category_id_uindex
    on product_category (product_asin, category_id);

create table reviews
(
    id           serial not null
        constraint reviews_pk
            primary key,
    date         date,
    customer     varchar,
    rating       integer,
    votes        integer,
    helpful      integer,
    product_asin varchar
        constraint reviews_products_asin_fk
            references products
);

alter table reviews
    owner to postgres;

create unique index reviews_id_uindex
    on reviews (id);

create table if not exists products
(
  id integer,
  asin varchar not null
    constraint products_pk
      primary key,
  title varchar,
  "group" varchar,
  salesrank integer
);

create unique index if not exists products_asin_uindex
  on products (asin);

create table if not exists similars
(
  asin_1 varchar not null
    constraint similars_products_asin_fk
      references products,
  asin_2 varchar
);

create table if not exists categories
(
  id integer not null
    constraint categories_pk
      primary key,
  name varchar
);

create table if not exists product_category
(
  product_asin varchar
    constraint product_category_products_asin_fk
      references products,
  category_id integer
    constraint product_category_categories_id_fk
      references categories
);

create unique index if not exists product_category_product_asin_category_id_uindex
  on product_category (product_asin, category_id);

create table if not exists reviews
(
  id serial not null
    constraint reviews_pk
      primary key,
  date date,
  customer varchar,
  rating integer,
  votes integer,
  helpful integer,
  product_asin varchar
    constraint reviews_products_asin_fk
      references products
);

create unique index if not exists reviews_id_uindex
  on reviews (id);
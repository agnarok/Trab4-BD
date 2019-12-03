-- Questao 5b:
select * from (similars JOIN products ON similars.asin_1 = products.asin) AS result
    JOIN products ON result.asin_2 = products.asin  where asin_1='0738700797' and result.salesrank < products.salesrank;

-- Questao 5d:
SELECT * FROM (
                SELECT *, rank() OVER (
                    PARTITION BY products."group"
                    ORDER BY products.salesrank DESC
                )
                FROM products
                WHERE salesrank notnull
                ) jobs WHERE  RANK <=10;

-- Questao 5e:
SELECT asin,title,avg(helpful) FROM products join reviews r on products.asin = r.product_asin GROUP BY (asin,title) order by avg(helpful) DESC LIMIT 10;

-- Questao 5f:
SELECT category_id,name,avg(helpful) FROM products join reviews r on products.asin = r.product_asin
    join product_category pc on products.asin = pc.product_asin
    join categories c on pc.category_id = c.id group by (category_id,name) order by avg(helpful) desc  limit 5;


-- Questao 5g:
SELECT customer,"group",count FROM (
                SELECT *, row_number()  OVER (
                    PARTITION BY "group"
                    ORDER BY count DESC
                )
                FROM ( SELECT count(customer),customer,"group" FROM reviews,products WHERE product_asin = asin GROUP BY customer,"group" ORDER BY "group",count(customer) DESC) xuei
            ) jobs WHERE row_number <= 10;
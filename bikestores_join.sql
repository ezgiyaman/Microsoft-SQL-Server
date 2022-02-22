
--JOIN
--(INNER) JOIN: İki tablodaki eklenen kayıtlar için kullanılır.
--LEFT (OUTER) JOIN: İki tablodaki eþleþen kayýtlar ve eklenmeyen sol kayıtlar için kullanılır.
--RIGHT (OUTER) JOIN: İki tablodaki eklenen kayıtlar ve eklenemeyen sağ kayıtlar için kullanılır.
--FULL (OUTER) JOIN: İki tablodaki eklenen kayıtlar ve eklenmeyen sol ve sağ kayıtlar için kullanılır. LEFT ve RIGHT JOIN birleşimidir.


use BikeStores

select product_name,
       category_name 
from production.products p
inner join production.categories c on c.category_id = p.category_id
order by product_name desc;

select category_name 
from production.categories c 
inner join production.products p on p.category_id = c.category_id 
inner join  production.brands b on p.brand_id = b.brand_id

select product_name,order_id
from sales.order_items o
    right join production.products p on o.product_id = p.product_id

select
    product_name,
    order_id
from production.products p
left join sales.order_items o on o.product_id = p.product_id
order by order_id;

select required_date,shipped_date,
       order_id 
from sales.orders o join sales.stores s on s. store_id  = o. store_id 
                    join production.stocks st on st. store_id = s.store_id
                    join production.products p on p. product_id = st.product_id 

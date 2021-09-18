
--JO�N
--(INNER) JOIN: �ki tablodaki e�le�en kay�tlar i�in kullan�l�r.
--LEFT (OUTER) JOIN: �ki tablodaki e�le�en kay�tlar ve e�le�meyen sol kay�tlar i�in kullan�l�r.
--RIGHT (OUTER) JOIN: �ki tablodaki e�le�en kay�tlar ve e�le�meyen sa� kay�tlar i�in kullan�l�r.
--FULL (OUTER) JOIN: �ki tablodaki e�le�en kay�tlar ve e�le�meyen sol ve sa� kay�tlar i�in kullan�l�r. LEFT ve RIGHT JOIN birle�imidir.


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

select required_date,shipped_date,order_id from sales.orders o join sales.stores s on s. store_id  = o. store_id 
                             join production.stocks st on st. store_id = s.store_id
							 join production.products p on p. product_id = st.product_id 













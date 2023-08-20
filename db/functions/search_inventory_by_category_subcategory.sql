create or replace function search_inventory_by_category_subcategory(category_id int4, subcategory_id int4) returns setof fleamarket.inventory_by_category_with_cart as $$
    	select * from fleamarket.inventory_by_category_with_cart
    	where category_id = category_id
		and subcategory_id = subcategory_id;
 $$ language sql stable;

create or replace function search_inventory_by_category(category_id int4) returns setof fleamarket.inventory_by_category_with_cart as $$
    	select * from fleamarket.inventory_by_category_with_cart
    	where category_id = category_id
 $$ language sql stable;
create or replace function fleamarket.search_inventory_by_category_subcategory(categoryId int4, subcategoryId int4) returns setof fleamarket.inventory_by_category_with_cart as $$
    	select * from fleamarket.inventory_by_category_with_cart
    	where category_id = categoryId
		and subcategory_id = subcategoryId;
 $$ language sql stable;

create or replace function fleamarket.search_inventory_by_category(categoryId int4) returns setof fleamarket.inventory_by_category_with_cart as $$
    	select * from fleamarket.inventory_by_category_with_cart
    	where category_id = categoryId
 $$ language sql stable;
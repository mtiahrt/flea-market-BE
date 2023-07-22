CREATE OR REPLACE FUNCTION fleamarket.search_inventory_by_category_with_cart(categoryid integer)
 RETURNS SETOF fleamarket.inventory_by_category_with_cart
 LANGUAGE sql
 STABLE
AS $function$
    -- Write our advanced query as a SQL query!
    select *
    from fleamarket.inventory_by_category_with_cart
    where category_id = categoryId
  $function$
;

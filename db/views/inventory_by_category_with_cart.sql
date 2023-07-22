-- fleamarket.inventory_by_category_with_cart source

CREATE OR REPLACE VIEW fleamarket.inventory_by_category_with_cart
AS SELECT i.id inventoryId,
    i.name inventoryName,
    i.description,
    i.quantity inventoryQuantity,
    i.manufacturer_name,
    i.price,
    c.id cartId,
    c.quantity cartQuantity,
    c.inventory_id AS cart_inventory_id,
    c.application_user_id,
    cat.id AS category_id,
    cat."name" categoryName,
    ii.id itemImageId,
    ii.url,
    ii.public_id
   FROM fleamarket.inventory i
    join fleamarket.subcategory sub
	on i.subcategory_id  = sub.id
join fleamarket.category cat
	on sub.category_id = cat.id
	and cat.id = 1
join fleamarket.item_image ii
	on i.id = ii.inventory_id
left  join fleamarket.cart c
	on i.id=c.inventory_id

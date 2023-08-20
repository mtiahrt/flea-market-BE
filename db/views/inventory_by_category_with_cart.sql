-- fleamarket.inventory_by_category_with_cart source

CREATE OR REPLACE VIEW fleamarket.inventory_by_category_with_cart
AS
SELECT i.id AS inventoryid,
    i.name AS inventoryname,
    i.description,
    i.quantity AS inventoryquantity,
    i.manufacturer_name,
    i.price,
    c.id AS cartid,
    c.quantity AS cartquantity,
    c.inventory_id AS cart_inventory_id,
    c.application_user_id,
    cat.id AS category_id,
    cat.name AS categoryname,
    ii.id AS itemimageid,
    ii.url,
    ii.public_id,
    sub.id as subcategory_id,
    sub."name" as subcategoryname
   FROM fleamarket.inventory i
     JOIN fleamarket.subcategory sub ON i.subcategory_id = sub.id
     JOIN fleamarket.category cat ON sub.category_id = cat.id
     JOIN fleamarket.item_image ii ON i.id = ii.inventory_id AND ii.id = (( SELECT item_image.id
           FROM fleamarket.item_image
          WHERE item_image.inventory_id = i.id
         LIMIT 1))
     LEFT JOIN fleamarket.cart c ON i.id = c.inventory_id;

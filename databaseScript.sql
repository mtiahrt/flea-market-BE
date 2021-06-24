--DROP TABLE public.item_image;
--drop table public.sale_item;
--drop table public.subcategory;
--drop table public.category;

--run this script against the postgres db in the public schema
CREATE TABLE category (
id SERIAL PRIMARY KEY,
name varchar(100) NOT NULL,
description varchar(100)
);

create table subcategory(
id SERIAL primary key,
category_id INT,
name varchar not null,
description varchar,
constraint fk_subcategory
foreign key (category_id)
references category(id)
);

CREATE TABLE public.sale_item (
	id serial NOT NULL,
	subcategory_id int4 NULL,
	name varchar(100) NOT NULL,
	description varchar NULL,
	manufacturer_name varchar(100) NULL,
	price numeric(5,2) NULL,
	CONSTRAINT sale_item_pkey PRIMARY KEY (id)
);

ALTER TABLE public.sale_item ADD CONSTRAINT fk_sale_item FOREIGN KEY (subcategory_id) 
REFERENCES subcategory(id);

CREATE TABLE public.item_image (
	id serial NOT NULL,
	sale_item_id int4 NOT NULL,
	url varchar NOT NULL,
	CONSTRAINT item_image_pk PRIMARY KEY (id)
);
-- public.item_image foreign keys
ALTER TABLE public.item_image ADD CONSTRAINT item_image_fk FOREIGN KEY (sale_item_id) 
REFERENCES public.sale_item(id) ON DELETE CASCADE;


CREATE SCHEMA app_private AUTHORIZATION postgres;

CREATE OR REPLACE FUNCTION app_private.notify_sale_item_insert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
	 perform pg_notify( 'postgraphile:saleItemInsertHappen',
  		json_build_object('__node__', 
    		json_build_array('sale_items',(select max(id) from public.sale_item))
  		)::text
	  );
return NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION app_private.validate_subscription(topic text)
 RETURNS text
 LANGUAGE sql
 STABLE
AS $function$
 select 'CANCEL_ALL_SUBSCRIPTIONS'::text;
$function$
;

create trigger sale_item_inserts after
insert
    on
    public.sale_item for each row execute function app_private.notify_sale_item_insert();

ALTER TABLE public.sale_item ADD CONSTRAINT fk_sale_item FOREIGN KEY (subcategory_id) REFERENCES subcategory(id);

--Table Inserts
INSERT INTO public.category
(id, "name", description)
values
(1, 'Clothes', 'Clothing Apparel'),
(2, 'Jewelry and Accessories', 'Jems and valuables'),
(3, 'Fine Things', 'Art and Collectables'),
(4, 'Household', 'Household goods'),
(5, 'Books', 'Good Reads'),
(6, 'New Arrivals', 'Our latest products'),
(7, 'Sale', 'Price discounted');

insert into subcategory 
(category_id, "name", description)
values
(1, 'Sweaters and Tops', null),
(1, 'Dresses and Skirts', null),
(1, 'Coats and Jackets', null),
(1, 'Jeans and Pants', null),
(1, 'Shoes', null),
(1, 'Active Wear', 'Gym Apparel'),
(1, 'Men', null),
(1, 'Women', null),
(1, 'children', null),
(1, 'Dress Up', 'fun and silly clothing'),
(2, 'Gold', null),
(2, 'Silver', null),
(2, 'Costume', null),
(2, 'Sunglasses and Scarves', null),
(2, 'Handbags and Wallets', null),
(2, 'Canes and Umbrellas', null),
(3, 'Artwork', null),
(3, 'Paintings', null),
(3, 'Photographs', null),
(3, 'Pottery', null),
(3, 'Wood Block', null),
(3, 'Collectables', null),
(4, 'Kitchen', null), 
(4, 'Outdoor', null),
(4, 'Toys', null),
(5, 'kids', null), 
(5, 'Young Adult', null),
(5, 'Textbooks', null),
(5, 'Fiction', null);

insert into public.sale_item
(subcategory_id , "name", manufacturer_name, price)
values
(1, 'Mens winter jacket', 'High Sierra', 102.25),
(1, 'Texas A&M', 'Captivating Headgear', 23.30),
(1, 'Pinehurst golf cap O/S adjustable back', 'Sweet hats', 23.30),
(1, 'Camouflage jogger', 'in the cut', 15),
(2, '1969 Western Belted Shirt Denim Dress', 'GAP', 45.63),
(2, 'Womens bracelet. Adjustable', 'D''Bello', 25.21),
(2, '14k Rose Gold Plated Designer Stud Earrings', 'Boutique', 150);

INSERT INTO public.item_image (sale_item_id,url) VALUES
(1,'https://media.pnca.edu/system/assets/5bf31603-1061-423b-a823-5ac478d67974/large/pnca_5bf31603-1061-423b-a823-5ac478d67974_large.jpg?1437580908'),
(1,'https://media.pnca.edu/system/assets/785aa38a-aea2-4613-9d01-2b700c184166/large/pnca_785aa38a-aea2-4613-9d01-2b700c184166_large.jpg?1437581001'),
(1,'https://media.pnca.edu/system/assets/5bf31603-1061-423b-a823-5ac478d67974/square/pnca_5bf31603-1061-423b-a823-5ac478d67974_square.jpg?1437580908'),
(1,'https://media.pnca.edu/system/assets/785aa38a-aea2-4613-9d01-2b700c184166/square/pnca_785aa38a-aea2-4613-9d01-2b700c184166_square.jpg?1437581001');

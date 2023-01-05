SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE SCHEMA IF NOT EXISTS fleamarket;

SET default_tablespace = '';
SET default_table_access_method = heap;


CREATE TABLE IF NOT exists fleamarket.category (
    id INT generated always as identity primary key,
    name character varying(100) NOT NULL,
    description character varying(100)
);


CREATE TABLE IF NOT exists fleamarket.subcategory (
    id INT generated always as identity primary key,
    category_id integer,
    name character varying NOT NULL,
    description character varying,
    constraint fk_subcategory_category_id foreign key(category_id) references fleamarket.category(id)
);

CREATE TABLE IF NOT exists fleamarket.inventory (
    id INT generated always as identity primary key,
    subcategory_id integer,
    name character varying(100) NOT NULL,
    description character varying,
    manufacturer_name character varying(100),
    price numeric(5,2),
    quantity int NULL DEFAULT 1,
    in_stock boolean DEFAULT true,
    constraint fk_inventory_subcategory_id foreign key(subcategory_id) references fleamarket.subcategory(id)
);

CREATE TABLE IF NOT exists fleamarket.item_image (
    id INT generated always as identity primary key,
    inventory_id integer NOT NULL,
    url character varying NOT NULL,
    public_id character varying,
    constraint fk_item_image_inventory_id foreign key(inventory_id) references fleamarket.inventory(id)
);


CREATE TABLE fleamarket.cart (
    id INT generated always as identity primary key,
	application_user_id VARCHAR(255) NOT NULL,
	inventory_id int4 NOT NULL,
	date_added date null default now(),
	quantity int DEFAULT 1,
	constraint fk_cart_inventory_id foreign key (inventory_id) references fleamarket.inventory(id)
);

CREATE TABLE IF NOT exists fleamarket.name (
    id INT generated always as identity primary key,
	application_user_id VARCHAR(255) NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying,
    phone_number character varying(100)
);

CREATE TABLE IF NOT exists fleamarket.address (
    id INT generated always as identity primary key,
    address_line_1 character varying NOT NULL,
    address_line_2 character varying,
    city character varying(100) not null,
    state_abbr character varying(2) NOT NULL,
    zip_code character varying(10) not null,
    billing_address boolean not null,
    shipping_address boolean not null
);

create table if not exists fleamarket.name_address (
	name_id int references fleamarket.name (id) on update cascade,
	address_id int references fleamarket.address (id) on update cascade,
	constraint name_address_pkey primary key (name_id, address_id)
);

CREATE TABLE IF NOT exists fleamarket.purchase (
    id INT generated always as identity primary key,
    name_id integer,
 	shipping_address_id integer,
    billing_address_id integer,
    inventory_id integer,
    product_name character varying(100) NOT NULL,
    product_description character varying,
    manufacturer_name character varying(100),
    price numeric(5,2),
    quantity int NULL DEFAULT 1,
    purchase_date date not null default CURRENT_DATE,
    constraint fk_purchase_name_id foreign key (name_id) references fleamarket.name(id),
    constraint fk_purchase_shipping_address_id foreign key (shipping_address_id)  references fleamarket.address(id),
    constraint fk_purchase_billing_address_id foreign key (billing_address_id)  references fleamarket.address(id)
);

CREATE TABLE IF NOT exists fleamarket.role (
    id INT generated always as identity primary key,
    user_id INT,
    name character varying(100) NOT null,
    constraint fk_role_user_id foreign key (user_id) references fleamarket.name(id)
);

INSERT into fleamarket.name
(application_user_id, first_name, last_name, email)
values 
('yi0ZyXuTp8dZ0NQPx0HTqZjNFF02', 'Mark', 'Tiahrt', 'marktpua@hotmail.com');

INSERT into fleamarket.role 
(user_id, name)
values
(1, 'admin');

INSERT INTO fleamarket.category (name, description) values
('Clothes','Clothing Apparel'),
('Jewelry and Accessories','Gems and valuables'),
('Fine Things','Art and Collectables'),
('Household','Household goods'),
('Books','Good Reads'),
('New Arrivals','Our latest products'),
('Sale','Price discounted');

INSERT INTO fleamarket.subcategory (category_id, name, description) VALUES
(1,'Sweaters and Tops',NULL),
(1,'Dresses and Skirts',NULL),
(1,'Coats and Jackets',NULL),
(1,'Jeans and Pants',NULL),
(1,'Shoes',NULL),
(1,'Active Wear','Gym Apparel'),
(1,'Men',NULL),
(1,'Women',NULL),
(1,'children',NULL),
(1,'Dress Up	fun and silly clothing', NULL),
(2,'Costume',NULL),
(2,'Sunglasses and Scarves',NULL),
(2,'Handbags and Wallets',NULL),
(2,'Canes and Umbrellas',NULL),
(3,'Artwork',NULL),
(3,'Printings',NULL),
(3,'Photographs',NULL),
(3,'Pottery',NULL),
(3,'Wood Block',NULL),
(3,'Collectables',NULL),
(4,'Kitchen',NULL),
(4,'Outdoor',NULL),
(4,'Toys',NULL),
(5,'kids',NULL),
(5,'Young Adult',NULL),
(5,'Textbooks',NULL),
(5,'Fiction',NULL);


INSERT INTO fleamarket.inventory ( subcategory_id, name, description, manufacturer_name, price, quantity) VALUES
(1,'Mens','winter jacket','High Sierra',102.25,2),
(1,'Texas A&M','Captivating Headgear', 'Forever Summer', 23.30,1),
(1,'Pinehurst golf cap','adjustable back','Sweet hats',23.30,5),
(1,'Camouflage jogger','in the cut','my winter',15.00,8),
(2,'1969 Western','Belted Shirt Denim Dress','GAP',45.63,3),
(2,'Womens bracelet','Adjustable','Bello',25.21,9),
(2,'14k','Rose Gold Plated Designer Stud Earrings','Boutique',150.00,100),
(2,'Main dress',	'Long dress with feathers','Bebe',32.00,40),
(2,'Main dress','Long dress with feathers','Bebe',32.00, 11),
(2,'Main dress','Long dress with feathers','Bebe',32.00, 9);

INSERT INTO fleamarket.item_image (inventory_id, url) values
(1,'https://media.pnca.edu/system/assets/5bf31603-1061-423b-a823-5ac478d67974/square/pnca_5bf31603-1061-423b-a823-5ac478d67974_square.jpg?1437580908'),
(1,'https://media.pnca.edu/system/assets/785aa38a-aea2-4613-9d01-2b700c184166/square/pnca_785aa38a-aea2-4613-9d01-2b700c184166_square.jpg?1437581001');

CREATE OR REPLACE FUNCTION fleamarket.update_inventory_quantity()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
  AS
$$
declare
    inventory_quantity integer;
    inStock boolean = true;
begin
	--get the current quantity is
   select INTO inventory_quantity quantity from fleamarket.inventory where id = NEW.inventory_id;
   if (inventory_quantity - new.quantity) < 1 then
   		select into inStock false;
   end if;
  	update fleamarket.inventory set quantity =  inventory_quantity - NEW.quantity,
  		in_stock = inStock
  	where id = new.inventory_id;
	RETURN NEW;
END;
$$

CREATE TRIGGER update_inventory_quantity
AFTER INSERT
ON fleamarket.purchase
FOR EACH ROW
EXECUTE PROCEDURE fleamarket.update_inventory_quantity()

CREATE TRIGGER inventory_inserts AFTER INSERT ON fleamarket.inventory FOR EACH ROW EXECUTE
FUNCTION app_private.notify_inventory_insert();

CREATE OR REPLACE FUNCTION postgraphile_watch.notify_watchers_ddl() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
begin
  perform pg_notify(
    'postgraphile_watch',
    json_build_object(
      'type',
      'ddl',
      'payload',
      (select json_agg(json_build_object('schema', schema_name, 'command', command_tag)) from pg_event_trigger_ddl_commands() as x)
    )::text
  );
end;
$$;
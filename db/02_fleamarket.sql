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
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(100)
);


CREATE SEQUENCE IF NOT exists fleamarket.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE fleamarket.category_id_seq OWNED BY fleamarket.category.id;

CREATE TABLE IF NOT exists fleamarket.item_image (
    id integer NOT NULL,
    inventory_id integer NOT NULL,
    url character varying NOT NULL,
    public_id character varying
);


CREATE SEQUENCE IF NOT exists fleamarket.item_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fleamarket.item_image_id_seq OWNED BY fleamarket.item_image.id;


CREATE TABLE IF NOT exists fleamarket.inventory (
    id integer NOT NULL,
    subcategory_id integer,
    name character varying(100) NOT NULL,
    description character varying,
    manufacturer_name character varying(100),
    price numeric(5,2)
);

CREATE SEQUENCE IF NOT exists fleamarket.inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fleamarket.inventory_id_seq OWNED BY fleamarket.inventory.id;


CREATE TABLE IF NOT exists fleamarket.subcategory (
    id integer NOT NULL,
    category_id integer,
    name character varying NOT NULL,
    description character varying
);


CREATE SEQUENCE IF NOT exists fleamarket.subcategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE fleamarket.subcategory_id_seq OWNED BY fleamarket.subcategory.id;

CREATE TABLE fleamarket.cart (
	id serial4 NOT NULL,
	userId varchar(200) NOT NULL,
	inventory_id int4 NOT NULL,
	date_added date null default now(),
	CONSTRAINT cart_pkey PRIMARY KEY (id)
);


CREATE SEQUENCE IF NOT exists fleamarket.cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE fleamarket.cart_id_seq OWNED BY fleamarket.cart.id;



ALTER TABLE ONLY fleamarket.category ALTER COLUMN id SET DEFAULT nextval('fleamarket.category_id_seq'::regclass);


ALTER TABLE ONLY fleamarket.item_image ALTER COLUMN id SET DEFAULT nextval('fleamarket.item_image_id_seq'::regclass);


ALTER TABLE ONLY fleamarket.inventory ALTER COLUMN id SET DEFAULT nextval('fleamarket.inventory_id_seq'::regclass);

ALTER TABLE ONLY fleamarket.subcategory ALTER COLUMN id SET DEFAULT nextval('fleamarket.subcategory_id_seq'::regclass);


INSERT INTO fleamarket.category (id, name, description) values
(1,'Clothes','Clothing Apparel'),
(2,'Jewelry and Accessories','Gems and valuables'),
(3,	'Fine Things','Art and Collectables'),
(4,	'Household','Household goods'),
(5,	'Books','Good Reads'),
(6,	'New Arrivals','Our latest products'),
(7,	'Sale','Price discounted');


INSERT INTO fleamarket.item_image (id, inventory_id, url) values
(1,1,'https://media.pnca.edu/system/assets/5bf31603-1061-423b-a823-5ac478d67974/square/pnca_5bf31603-1061-423b-a823-5ac478d67974_square.jpg?1437580908'),
(2,1,'https://media.pnca.edu/system/assets/785aa38a-aea2-4613-9d01-2b700c184166/square/pnca_785aa38a-aea2-4613-9d01-2b700c184166_square.jpg?1437581001');



INSERT INTO fleamarket.inventory (id, subcategory_id, name, description, manufacturer_name, price) VALUES
(1,1,'Mens','winter jacket','High Sierra',102.25),
(2,1,'Texas A&M','Captivating Headgear', 'Forever Summer', 23.30),
(3,1,'Pinehurst golf cap','adjustable back','Sweet hats',23.30),
(4,1,'Camouflage jogger','in the cut','my winter',15.00),
(5,2,'1969 Western','Belted Shirt Denim Dress','GAP',45.63),
(6,	2,'Womens bracelet','Adjustable','Bello',25.21),
(7,	2,'14k','Rose Gold Plated Designer Stud Earrings','Boutique',150.00),
(8,	2,'Main dress',	'Long dress with feathers','Bebe',32.00),
(9,	2,'Main dress','Long dress with feathers','Bebe',32.00),
(10,2,'Main dress','Long dress with feathers','Bebe',32.00),
(11,2,'Main dress','Long dress with feathers','Bebe',32.00),
(12,2,'Main dress','Long dress with feathers','Bebe',32.00),
(13,2,'Main dress','Long dress with feathers','Bebe',32.00),
(14,2,'Main dress','Long dress with feathers','Bebe',32.00),
(15,2,'Main dress','Long dress with feathers','Bebe',32.00),
(16,2,'Main dress','Long dress with feathers','Bebe',32.00),
(17,2,'Main dress','Long dress with feathers','Bebe',32.00),
(18,2,'Main dress','Long dress with feathers','Bebe',32.00),
(19,2,'Main dress','Long dress with feathers','Bebe',32.00),
(20,2,'Main dress','Long dress with feathers','Bebe',32.00),
(21,2,'Main dress','Long dress with feathers','Bebe',32.00),
(22,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(23,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(24,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(25,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(26,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(27,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(28,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(29,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(30,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(31,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(32,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(33,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(34,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(35,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(36,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(37,2, 'Main dress','Long dress with feathers','Bebe',32.00),
(38,2, 'Main dress','Long dress with feathers','Bebe',32.00);


INSERT INTO fleamarket.subcategory (id, category_id, name, description) VALUES
(1,1,'Sweaters and Tops',NULL),
(2,1,'Dresses and Skirts',NULL),
(3,1,'Coats and Jackets',NULL),
(4,1,'Jeans and Pants',NULL),
(5,1,'Shoes',NULL),
(6,1,'Active Wear','Gym Apparel'),
(7,1,'Men',NULL),
(8,1,'Women',NULL),
(9,1,'children',NULL),
(10,1,'Dress Up	fun and silly clothing', NULL),
(13,2,'Costume',NULL),
(14,2,'Sunglasses and Scarves',NULL),
(15,2,'Handbags and Wallets',NULL),
(16,2,'Canes and Umbrellas',NULL),
(17,3,'Artwork',NULL),
(18,3,'Printings',NULL),
(19,3,'Photographs',NULL),
(20,3,'Pottery',NULL),
(21,3,'Wood Block',NULL),
(22,3,'Collectables',NULL),
(23,4,'Kitchen',NULL),
(24,4,'Outdoor',NULL),
(25,4,'Toys',NULL),
(26,5,'kids',NULL),
(27,5,'Young Adult',NULL),
(28,5,'Textbooks',NULL),
(29,5,'Fiction',NULL);


SELECT pg_catalog.setval('fleamarket.category_id_seq', 8, false);


SELECT pg_catalog.setval('fleamarket.item_image_id_seq', 3, true);


SELECT pg_catalog.setval('fleamarket.inventory_id_seq', 39, true);


SELECT pg_catalog.setval('fleamarket.subcategory_id_seq', 30, true);


ALTER TABLE ONLY fleamarket.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


ALTER TABLE ONLY fleamarket.item_image
    ADD CONSTRAINT item_image_pk PRIMARY KEY (id);


ALTER TABLE ONLY fleamarket.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);


ALTER TABLE ONLY fleamarket.subcategory
    ADD CONSTRAINT subcategory_pkey PRIMARY KEY (id);


CREATE TRIGGER inventory_inserts AFTER INSERT ON fleamarket.inventory FOR EACH ROW EXECUTE
FUNCTION app_private.notify_inventory_insert();


ALTER TABLE ONLY fleamarket.inventory
    ADD CONSTRAINT fk_inventory FOREIGN KEY (subcategory_id) REFERENCES fleamarket.subcategory(id);


ALTER TABLE ONLY fleamarket.subcategory
    ADD CONSTRAINT fk_subcategory FOREIGN KEY (category_id) REFERENCES fleamarket.category(id);



ALTER TABLE ONLY fleamarket.item_image
    ADD CONSTRAINT item_image_fk FOREIGN KEY (inventory_id) REFERENCES fleamarket.inventory(id) ON DELETE CASCADE;

ALTER TABLE fleamarket.cart
    ADD CONSTRAINT fk_inventory FOREIGN KEY (inventory_id) REFERENCES fleamarket.inventory(id);


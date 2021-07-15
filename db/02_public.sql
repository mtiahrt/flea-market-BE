--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2021-07-14 12:20:55 MDT

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

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

--CREATE SCHEMA public;


--
-- TOC entry 3303 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

-- COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 203 (class 1259 OID 16461)
-- Name: category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(100)
);


--
-- TOC entry 202 (class 1259 OID 16459)
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3304 (class 0 OID 0)
-- Dependencies: 202
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- TOC entry 209 (class 1259 OID 40967)
-- Name: item_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_image (
    id integer NOT NULL,
    sale_item_id integer NOT NULL,
    url character varying NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 40965)
-- Name: item_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.item_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3305 (class 0 OID 0)
-- Dependencies: 208
-- Name: item_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.item_image_id_seq OWNED BY public.item_image.id;


--
-- TOC entry 207 (class 1259 OID 16485)
-- Name: sale_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sale_item (
    id integer NOT NULL,
    subcategory_id integer,
    name character varying(100) NOT NULL,
    description character varying,
    manufacturer_name character varying(100),
    price numeric(5,2)
);


--
-- TOC entry 206 (class 1259 OID 16483)
-- Name: sale_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sale_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3306 (class 0 OID 0)
-- Dependencies: 206
-- Name: sale_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sale_item_id_seq OWNED BY public.sale_item.id;


--
-- TOC entry 205 (class 1259 OID 16469)
-- Name: subcategory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subcategory (
    id integer NOT NULL,
    category_id integer,
    name character varying NOT NULL,
    description character varying
);


--
-- TOC entry 204 (class 1259 OID 16467)
-- Name: subcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.subcategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3307 (class 0 OID 0)
-- Dependencies: 204
-- Name: subcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subcategory_id_seq OWNED BY public.subcategory.id;


--
-- TOC entry 3144 (class 2604 OID 16464)
-- Name: category id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- TOC entry 3147 (class 2604 OID 40970)
-- Name: item_image id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_image ALTER COLUMN id SET DEFAULT nextval('public.item_image_id_seq'::regclass);


--
-- TOC entry 3146 (class 2604 OID 16488)
-- Name: sale_item id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_item ALTER COLUMN id SET DEFAULT nextval('public.sale_item_id_seq'::regclass);


--
-- TOC entry 3145 (class 2604 OID 16472)
-- Name: subcategory id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategory ALTER COLUMN id SET DEFAULT nextval('public.subcategory_id_seq'::regclass);


--
-- TOC entry 3291 (class 0 OID 16461)
-- Dependencies: 203
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.category (id, name, description) FROM stdin;
1	Clothes	Clothing Apparel
2	Jewelry and Accessories	Jems and valuables
3	Fine Things	Art and Collectables
4	Household	Household goods
5	Books	Good Reads
6	New Arrivals	Our latest products
7	Sale	Price discounted
\.


--
-- TOC entry 3297 (class 0 OID 40967)
-- Dependencies: 209
-- Data for Name: item_image; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.item_image (id, sale_item_id, url) FROM stdin;
1	1	https://media.pnca.edu/system/assets/5bf31603-1061-423b-a823-5ac478d67974/square/pnca_5bf31603-1061-423b-a823-5ac478d67974_square.jpg?1437580908
2	1	https://media.pnca.edu/system/assets/785aa38a-aea2-4613-9d01-2b700c184166/square/pnca_785aa38a-aea2-4613-9d01-2b700c184166_square.jpg?1437581001
\.


--
-- TOC entry 3295 (class 0 OID 16485)
-- Dependencies: 207
-- Data for Name: sale_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sale_item (id, subcategory_id, name, description, manufacturer_name, price) FROM stdin;
1	1	Mens winter jacket	\N	High Sierra	102.25
2	1	Texas A&M	\N	Captivating Headgear	23.30
3	1	Pinehurst golf cap O/S adjustable back	\N	Sweet hats	23.30
4	1	Camouflage jogger	\N	in the cut	15.00
5	2	1969 Western Belted Shirt Denim Dress	\N	GAP	45.63
6	2	Womens bracelet. Adjustable	\N	D'Bello	25.21
7	2	14k Rose Gold Plated Designer Stud Earrings	\N	Boutique	150.00
8	2	Main dress	Long dress with feathers	Bebe	32.00
9	2	Main dress	Long dress with feathers	Bebe	32.00
10	2	Main dress	Long dress with feathers	Bebe	32.00
11	2	Main dress	Long dress with feathers	Bebe	32.00
12	2	Main dress	Long dress with feathers	Bebe	32.00
13	2	Main dress	Long dress with feathers	Bebe	32.00
14	2	Main dress	Long dress with feathers	Bebe	32.00
15	2	Main dress	Long dress with feathers	Bebe	32.00
16	2	Main dress	Long dress with feathers	Bebe	32.00
17	2	Main dress	Long dress with feathers	Bebe	32.00
18	2	Main dress	Long dress with feathers	Bebe	32.00
19	2	Main dress	Long dress with feathers	Bebe	32.00
20	2	Main dress	Long dress with feathers	Bebe	32.00
21	2	Main dress	Long dress with feathers	Bebe	32.00
22	2	Main dress	Long dress with feathers	Bebe	32.00
23	2	Main dress	Long dress with feathers	Bebe	32.00
24	2	Main dress	Long dress with feathers	Bebe	32.00
25	2	Main dress	Long dress with feathers	Bebe	32.00
26	2	Main dress	Long dress with feathers	Bebe	32.00
27	2	Main dress	Long dress with feathers	Bebe	32.00
28	2	Main dress	Long dress with feathers	Bebe	32.00
29	2	Main dress	Long dress with feathers	Bebe	32.00
30	2	Main dress	Long dress with feathers	Bebe	32.00
31	2	Main dress	Long dress with feathers	Bunny's	32.00
32	2	Main dress	Long dress with feathers	Bunny's	32.00
33	2	Main dress	Long dress with feathers	Bunny's	32.00
34	2	Main dress	Long dress with feathers	Bunny's	32.00
35	2	Main dress	Long dress with feathers	Bebe	32.00
36	2	Main dress	Long dress with feathers	Bebe	32.00
37	2	Main dress	Long dress with feathers	Bebe1	32.00
38	2	Main dress	Long dress with feathers	Bebe1	32.00
\.


--
-- TOC entry 3293 (class 0 OID 16469)
-- Dependencies: 205
-- Data for Name: subcategory; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.subcategory (id, category_id, name, description) FROM stdin;
1	1	Sweaters and Tops	\N
2	1	Dresses and Skirts	\N
3	1	Coats and Jackets	\N
4	1	Jeans and Pants	\N
5	1	Shoes	\N
6	1	Active Wear	Gym Apparel
7	1	Men	\N
8	1	Women	\N
9	1	children	\N
10	1	Dress Up	fun and silly clothing
11	2	Gold	\N
12	2	Silver	\N
13	2	Costume	\N
14	2	Sunglasses and Scarves	\N
15	2	Handbags and Wallets	\N
16	2	Canes and Umbrellas	\N
17	3	Artwork	\N
18	3	Paintings	\N
19	3	Photographs	\N
20	3	Pottery	\N
21	3	Wood Block	\N
22	3	Collectables	\N
23	4	Kitchen	\N
24	4	Outdoor	\N
25	4	Toys	\N
26	5	kids	\N
27	5	Young Adult	\N
28	5	Textbooks	\N
29	5	Fiction	\N
\.


--
-- TOC entry 3308 (class 0 OID 0)
-- Dependencies: 202
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.category_id_seq', 1, false);


--
-- TOC entry 3309 (class 0 OID 0)
-- Dependencies: 208
-- Name: item_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.item_image_id_seq', 2, true);


--
-- TOC entry 3310 (class 0 OID 0)
-- Dependencies: 206
-- Name: sale_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sale_item_id_seq', 38, true);


--
-- TOC entry 3311 (class 0 OID 0)
-- Dependencies: 204
-- Name: subcategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.subcategory_id_seq', 29, true);


--
-- TOC entry 3149 (class 2606 OID 16466)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 3155 (class 2606 OID 40975)
-- Name: item_image item_image_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_image
    ADD CONSTRAINT item_image_pk PRIMARY KEY (id);


--
-- TOC entry 3153 (class 2606 OID 16493)
-- Name: sale_item sale_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_item
    ADD CONSTRAINT sale_item_pkey PRIMARY KEY (id);


--
-- TOC entry 3151 (class 2606 OID 16477)
-- Name: subcategory subcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategory
    ADD CONSTRAINT subcategory_pkey PRIMARY KEY (id);


--
-- TOC entry 3159 (class 2620 OID 16497)
-- Name: sale_item sale_item_inserts; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER sale_item_inserts AFTER INSERT ON public.sale_item FOR EACH ROW EXECUTE FUNCTION app_private.notify_sale_item_insert();


--
-- TOC entry 3157 (class 2606 OID 16499)
-- Name: sale_item fk_sale_item; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_item
    ADD CONSTRAINT fk_sale_item FOREIGN KEY (subcategory_id) REFERENCES public.subcategory(id);


--
-- TOC entry 3156 (class 2606 OID 16478)
-- Name: subcategory fk_subcategory; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subcategory
    ADD CONSTRAINT fk_subcategory FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- TOC entry 3158 (class 2606 OID 40976)
-- Name: item_image item_image_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_image
    ADD CONSTRAINT item_image_fk FOREIGN KEY (sale_item_id) REFERENCES public.sale_item(id) ON DELETE CASCADE;


-- Completed on 2021-07-14 12:20:55 MDT

--
-- PostgreSQL database dump complete
--


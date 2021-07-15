--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2021-07-14 12:43:44 MDT

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
-- TOC entry 6 (class 2615 OID 16495)
-- Name: app_private; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA app_private;


--
-- TOC entry 210 (class 1255 OID 16496)
-- Name: notify_sale_item_insert(); Type: FUNCTION; Schema: app_private; Owner: -
--

CREATE FUNCTION app_private.notify_sale_item_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	 perform pg_notify( 'postgraphile:saleItemInsertHappen',
  		json_build_object('__node__', 
    		json_build_array('sale_items',(select max(id) from public.sale_item))
  		)::text
	  );
return NEW;
END;
$$;


--
-- TOC entry 211 (class 1255 OID 16498)
-- Name: validate_subscription(text); Type: FUNCTION; Schema: app_private; Owner: -
--

CREATE FUNCTION app_private.validate_subscription(topic text) RETURNS text
    LANGUAGE sql STABLE
    AS $$
 select 'CANCEL_ALL_SUBSCRIPTIONS'::text;
$$;


-- Completed on 2021-07-14 12:43:44 MDT

--
-- PostgreSQL database dump complete
--


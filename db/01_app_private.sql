
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

CREATE SCHEMA app_private;

CREATE OR REPLACE FUNCTION app_private.notify_inventory_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	 perform pg_notify( 'postgraphile:inventoryInsertHappen',
  		json_build_object('__node__', 
    		json_build_array('inventory',(select max(id) from fleamarket.inventory))
  		)::text
	  );
return NEW;
END;
$$;


CREATE OR REPLACE FUNCTION app_private.validate_subscription(topic text) RETURNS text
    LANGUAGE sql STABLE
    AS $$
 select 'CANCEL_ALL_SUBSCRIPTIONS'::text;
$$;



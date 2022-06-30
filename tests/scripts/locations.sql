-- Documentation for PGTap can be found:
-- https://pgtap.org/documentation.html
-- CREATE EXTENSION IF NOT EXISTS pgtap;

-- Turn off echo and keep things quiet.
\unset ECHO
\set QUIET 1


-- Format the output for nice TAP.
\pset format unaligned
\pset tuples_only true
\pset pager off

-- Revert all changes on failure.
\set ON_ERROR_ROLLBACK 1
\set ON_ERROR_STOP true

-- #####################################
-- 1. TABLE TEST
-- #####################################
BEGIN;

SELECT plan(46);
SELECT has_table('locations');
SELECT col_not_null('locations', 'id');
SELECT col_not_null('locations', 'country_id');
SELECT col_not_null('locations', 'state_id');
SELECT has_column('locations', 'county_name');
SELECT col_not_null('locations', 'city_id');
SELECT col_not_null('locations', 'postal_code');
SELECT col_not_null('locations', 'street_address');
SELECT col_has_default('locations', 'address_line_2');
SELECT has_column('locations', 'address_line_3');
-- Keys
SELECT col_is_pk('locations', 'id');
-- Constrains
SELECT col_is_unique('locations', ARRAY['country_id', 'state_id', 'city_id', 'postal_code', 'street_address',  'address_line_2']);

-- SELECT * FROM finish();
-- ROLLBACK;

-- #####################################
-- 2. FUNCTION TEST
-- #####################################
-- Seed data for function tests
\set next_id 'nextval(pg_get_serial_sequence('locations', 'id')) as new_id;'
\set city_name '\'Reno\''
\set country_id 236
\set country_name '\'United States\''
\set state_id 29
\set state_name '\'Nevada\''
\set city_id 2
\set county_name '\'Washoe\''
\set postal_code '\'89521\''
\set street_address '\'Test 1\''
\set update_street_address '\'New Test 1\''
\set street_address2 '\'Test 2\''
\set update_street_address2 '\'New Test 2\''
\set address_line_2 '\'Test Department 1\''

--## insert_location tests ##--

-- Test 13. function exists
SELECT has_function('insert_location', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
], 'insert_location exists');

-- 14. verify function returns integer
SELECT function_returns('insert_location', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
], 'integer', 'insert_location returns integer');

-- Test 15. verify function language
SELECT function_lang_is('insert_location', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
], 'plpgsql', 'insert_location is plpgsql');

-- Test 16. insert returns integer on success
SELECT isa_ok (
  insert_location(
    :country_name,
    :state_name,
    :city_name,
    :postal_code,
    :street_address,
    :address_line_2
  ), 'integer',
  'insert_location return integer');

-- Test 17. verify data in locations table is inserted
SELECT is(
  street_address,
  :street_address,
  'insert_location verify insert'
) FROM locations
WHERE
  country_id = :country_id AND
  state_id = :state_id AND
  city_id = :city_id AND
  postal_code = :postal_code AND
  street_address = :street_address AND
  address_line_2 = :address_line_2;

-- Test 18. function exists
SELECT has_function('insert_location', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying'
], 'insert_location exists');

-- Test 19. function returns integer
SELECT function_returns('insert_location', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying'
], 'integer', 'insert_location returns integer');

-- Test 20. function language is
SELECT function_lang_is('insert_location', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying'
], 'plpgsql', 'insert_location is plpgsql');

-- Test 21. on insert return integer on success
SELECT isa_ok (
  insert_location(
    :country_name,
    :state_name,
    :city_name,
    :postal_code,
    :street_address2
  ), 'integer',
  'insert_location return integer');

-- Test 22. verify data in locations table is inserted
SELECT is(
  street_address,
  :street_address2,
  'insert_location verify insert'
) FROM locations
WHERE
  country_id = :country_id AND
  state_id = :state_id AND
  city_id = :city_id AND
  postal_code = :postal_code AND
  street_address = :street_address2;


--## get_location_id ##--

-- Test 23. function exists
SELECT has_function('get_location_id', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
], 'get_location_id exists');

-- Test 24. function language is plpgsql
SELECT function_lang_is('get_location_id', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
], 'plpgsql', 'get_location_id is plpgsql');

-- Test 25. function return type is integer
SELECT function_returns('get_location_id', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
],'integer' ,  'get_location_id returns integer');

-- Test 26. insert returns integer on success
SELECT isa_ok (
  get_location_id(
    :country_name,
    :state_name,
    :city_name,
    :postal_code,
    :street_address,
    :address_line_2
  ), 'integer',
  'get_location_id return integer');

-- Test 27. insert returns ok on success
SELECT matches (
  get_location_id(
    :country_name,
    :state_name,
    :city_name,
    :postal_code,
    :street_address,
    :address_line_2
  )::TEXT, '^0*[0-9]\d*$',
  'get_location_id return integer greter then 0');

-- Test 28. function exists
SELECT has_function('get_location_id', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying'
], 'get_location_id exists');

-- Test 29. function language is plpgsql
SELECT function_lang_is('get_location_id', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying'
], 'plpgsql', 'get_location_id is plpgsql');

-- Test 30. function return type is integer
SELECT function_returns('get_location_id', ARRAY [
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying'
],'integer' ,  'get_location_id returns integer');

-- Test 31. insert returns integer
SELECT isa_ok (
  get_location_id(
    :country_name,
    :state_name,
    :city_name,
    :postal_code,
    :street_address2
  ), 'integer',
  'get_location_id return integer');

-- Test 32. insert returns ok on success
SELECT matches (
  get_location_id(
    :country_name,
    :state_name,
    :city_name,
    :postal_code,
    :street_address2
  )::TEXT, '^0*[0-9]\d*$',
  'get_location_id return integer greter then 0');

--## update_location ##--
-- Test 33. function exists
SELECT has_function('update_location', ARRAY [
  'integer',
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
], 'update_location exists');

-- Test 34. function language is plpgsql
SELECT function_lang_is('update_location', ARRAY [
  'integer',
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying',
  'character varying'
], 'plpgsql', 'update_location is plpgsql');

-- Test 35. function exists
SELECT has_function('update_location', ARRAY [
  'integer',
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying'
], 'update_location exists');

-- Test 36. function language is plpgsql
SELECT function_lang_is('update_location', ARRAY [
  'integer',
  'character varying',
  'character',
  'character varying',
  'character',
  'character varying'
], 'plpgsql', 'update_location is plpgsql');

-- Test 37. verify return type boolean
SELECT isa_ok (
  update_location(
    get_location_id(
      :country_name,
      :state_name,
      :city_name,
      :postal_code,
      :update_street_address
    ),
    :country_name,
    :state_name,
    :city_name,
    :postal_code,
    :street_address,
    :address_line_2
  ), 'boolean',
  'update_location returns boolean');

-- Test 38. insert return type boolean
SELECT isa_ok (
  update_location(
        get_location_id(
      :country_name,
      :state_name,
      :city_name,
      :postal_code,
      :update_street_address2
    ),
    :country_name,
    :state_name,
    :city_name,
    :postal_code,
    :street_address2
  ), 'boolean',
  'update_location returns boolean');

-- Test 39. insert returns ok on success
SELECT ok (
  update_location(
    get_location_id(
      :country_name,
      :state_name,
      :city_name,
      :postal_code,
      :street_address,
      :address_line_2
    ),
    :country_name,
    :state_name,
    :city_name,
    :postal_code,
    :update_street_address,
    :address_line_2
  ), 'update_location return true on success');

-- Test 40. verify data in locations table is inserted
SELECT is(
  street_address,
  :update_street_address,
  'update_location verify insert'
) FROM locations
WHERE
  country_id = :country_id AND
  state_id = :state_id AND
  city_id = :city_id AND
  postal_code = :postal_code AND
  street_address = :update_street_address AND
  address_line_2 = :address_line_2;

-- Test 41. insert returns ok on success
SELECT ok (
  update_location(
    get_location_id(
      :country_name,
      :state_name,
      :city_name,
      :postal_code,
      :street_address2
    ),
    :country_name,
    :state_name,
    :city_name,
    :postal_code,
    :update_street_address2
  ), 'update_location return true on success');

-- Test 42. verify data in locations table is inserted
SELECT is(
  street_address,
  :update_street_address2,
  'update_location verify insert'
) FROM locations
WHERE
  country_id = :country_id AND
  state_id = :state_id AND
  city_id = :city_id AND
  postal_code = :postal_code AND
  street_address = :update_street_address2 ;

--## delete_function ##--
-- Test 43. function exists
SELECT has_function('delete_location', ARRAY [
  'integer'
], 'delete_location exists');

-- Test 44. function language is plpgsql
SELECT function_lang_is('delete_location', ARRAY [
  'integer'
], 'plpgsql' , 'delete_location is plpgsql');

-- Test 45. delete return type boolean
SELECT isa_ok (
  delete_location(
    get_location_id(
      :country_name,
      :state_name,
      :city_name,
      :postal_code,
      :update_street_address
      :address_line_2
    )), 'boolean',
  'delete_location returns boolean');

-- Test 46. delete returns ok on success
SELECT ok (
  delete_location(
    get_location_id(
      :country_name,
      :state_name,
      :city_name,
      :postal_code,
      :update_street_address2
    )),
  'delete_location return true on success');

SELECT * FROM finish();
ROLLBACK


-- SELECT diag(
--   E'This is a test \n',
--   'id : ', id,  
--   E'\tstreet address: ', street_address,
--   E'\taddress_line_2: ', address_line_2,
--   E'\n'
-- )FROM locations
-- WHERE 
--   country_id = :country_id AND
--   state_id = :state_id AND
--   city_id = :city_id AND
--   postal_code = :postal_code AND
--   street_address = :street_address AND
--   address_line_2 = :address_line_2
-- ;

-- PREPARE mythrow AS SELECT insert_location(
--       :country_name,
--       :state_name,
--       :city_name,
--       :postal_code,
--       :street_address,
--       :address_line_2
--     );

-- -- throws error unique key constraint 
--   SELECT throws_ok(
--       'mythrow', '23505', 'unique_violation',
--     'insert_location unique key constraint'
-- );
-- DEALLOCATE mythrow;

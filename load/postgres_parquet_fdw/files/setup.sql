create extension parquet_fdw;

create server parquet_srv foreign data wrapper parquet_fdw;

create user mapping for postgres server parquet_srv options (user 'postgres');


-- create foreign table events (
--     "type" text,
--     category   text,
--     "action"    text,
--     label text,
--     meta json
-- )

-- server parquet_srv
--   options (
--     filename '/data/ink-test-analytics-stream.parquet',
--   );
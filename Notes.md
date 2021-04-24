# Data Notes

SQL databases behave less like object collections the more size and performance matter;
object collections behave less like tables and rows the more abstractions start to matter.

The `database` is a `relational algebra engine`.   

Units can be composed into larger structures.

All processes are fully exposed within a series of composable, transparent tools.

# Citus Extension
[Citus](https://github.com/citusdata/citus) which we can deploy with Azure is a PostgreSQL extension that allows distributed queries and columnar storage.

```SQL
/*
import foreign schema "/data/parquet"
from server parquet_srv
into public;

create function list_parquet_files(args jsonb)
returns text[] as
$$
begin
    return array_agg(args->>'dir' || '/' || filename)
           from pg_ls_dir(args->>'dir') as files(filename)
           where filename ~~ '%.parquet';
end
$$
language plpgsql;

*/
select import_parquet_explicit(
    'events-8',
    'public',
    'parquet_srv',
    array['type', 'category', 'action','label'],
    array['text', 'text', 'text', 'text']::regtype[],
    'list_parquet_files',
    '{"dir": "/data/parquet"}',
    '{"sorted": "action"}'
);


select * from "events-8"
``
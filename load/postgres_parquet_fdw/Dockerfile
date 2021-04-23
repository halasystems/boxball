FROM postgres:13.2 as pg
RUN apt-get update && apt-get install -y --no-install-recommends postgresql-server-dev-13 build-essential zstd libprotobuf-c-dev protobuf-c-compiler wget cmake ca-certificates unzip make gcc libpq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

FROM pg as arrow
# ARROW
WORKDIR  /

#--chown=postgres:postgre
COPY ./install_arrow.sh . 
RUN chmod +x ./install_arrow.sh
RUN ./install_arrow.sh
# RUN wget https://github.com/apache/arrow/archive/refs/heads/master.zip -O arrow.zip && \
#     unzip arrow.zip && \
#     mv arrow-master arrow && mkdir /arrow/cpp/release 
# WORKDIR  /arrow/cpp/release    
# RUN cmake .. && make

FROM arrow as fdw

# PARQUET-FDW
WORKDIR  /

RUN wget https://github.com/adjust/parquet_fdw/archive/refs/heads/master.zip -O parquet_fdw.zip && \
    unzip parquet_fdw.zip && \
    mv parquet_fdw-master parquet_fdw

WORKDIR /parquet_fdw
RUN make install

#COPY ./ink-test-analytics-stream.parquet .

#RUN create extension parquet_fdw; in psql

# COPY --chown=postgres:postgres --from=ddl /ddl/postgres_cstore_fdw.sql /docker-entrypoint-initdb.d/
# COPY --chown=postgres:postgres --from=csv /transform/csv /data
# RUN cat /docker-entrypoint-initdb.d/postgres_cstore_fdw.sql
# WORKDIR /


# RUN echo "shared_preload_libraries = 'cstore_fdw'" >> "${PGDATA}/postgresql.conf"
COPY ./files/setup.sql /docker-entrypoint-initdb.d/
# COPY --chown=postgres:postgres --from=csv /transform/csv /data
# RUN cat /docker-entrypoint-initdb.d/postgres_cstore_fdw.sql

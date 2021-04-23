.PHONY: drill

drill:
	docker-compose run --rm --service-ports drill	

postgres-parquet:
	docker-compose build postgres-parquet-fdw
	docker-compose up -d postgres-parquet-fdw
	docker-compose up -d pgadmin
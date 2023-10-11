DB_URL=postgresql://root:M45uk4j4@localhost:5432/dblearning?sslmode=disable

postgres:
	docker run --name postgres-go --network dimas-net -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=M45uk4j4 -d postgres:14-alpine
	
createdb:
	docker exec -it postgres-go createdb --username=root --owner=root dblearning

dropdb:
	docker exec -it postgres-go dropdb dblearning

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc
postgres:
	sudo docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=1234 -d postgres
removePostgres:
	sudo docker rm postgres12
createdb:
	sudo docker exec -it postgres12 createdb --username=root --owner=root simple_bank
dropdb:
	sudo docker exec -it postgres12 dropdb simple_bank
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
migrateup:
	migrate -path db/migration -database "postgresql://root:1234@localhost:5432/simple_bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:1234@localhost:5432/simple_bank?sslmode=disable" -verbose down

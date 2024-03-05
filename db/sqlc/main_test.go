package db

import (
	"context"
	"log"
	"os"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"
	_ "github.com/lib/pq"
)

const dbSource = "postgresql://root:1234@localhost:5432/simple_bank?sslmode=disable"

var testStore *SQLStore

// main start point of all go test cases

func TestMain(m *testing.M) {

	connPool, err := pgxpool.New(context.Background(), dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testStore = NewStore(connPool)
	os.Exit(m.Run())
}

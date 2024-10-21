include ./backend/.env

NODE_PKG_MANAGER = bun 
NODE_RUNNER = bunx

PROTO_DEST_NEXT = ./src/server/proto
PROTO_DEST_GO = ./backend

# Converts .proto files to go types for implementation
go-generate-proto:
	rm -rf ${PROTO_DEST_GO}/proto/*
	protoc --go_out=${PROTO_DEST_GO} --go_opt=paths=source_relative --go-grpc_out=${PROTO_DEST_GO} --go-grpc_opt=paths=source_relative proto/*.proto

# Converts .proto files to TS 
next-generate-proto:
	rm -rf frontend/${PROTO_DEST_NEXT}/*
	cd frontend && ${NODE_RUNNER} grpc_tools_node_protoc --plugin=protoc-gen-ts_proto=./node_modules/.bin/protoc-gen-ts_proto --ts_proto_out=${PROTO_DEST_NEXT} --ts_proto_opt=outputServices=grpc-js --ts_proto_opt=esModuleInterop=true --ts_proto_opt=env=node -I ../proto ../proto/*.proto

# Generates all proto definitions
generate-proto: go-generate-proto next-generate-proto


# Setup the frontend
next-setup:
	cd frontend && ${NODE_PKG_MANAGER} install

# Setup the DB
db-setup:
	cd backend/scripts && ./start-database.sh
	source backend/.env && cd backend && atlas migrate apply --env local --var db_url=${DATABASE_URL}

# Seed the DB
db-seed:
	cd backend && go run main.go seed_db

# Reset the DB
db-data-erase:
	cd backend && go run main.go erase_db 


# Runs the backend server
go-run:
	cd backend && go run main.go start

# Runs the backend server for development (Live reload)
go-run-dev:
	cd backend && air

# Runs the frontend server
next-run:
	cd frontend && ${NODE_PKG_MANAGER} run dev


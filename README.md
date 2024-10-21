# AlgoHub 

## Requirements

- Protobuf compiler (protoc)
- Atlas CLI (https://atlasgo.io/)
- Golang
    - `go install google.golang.org/protobuf/cmd/protoc-gen-go@latest`
    - `go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest`
- Postgres DB (Docker setup provided)
- Node.js / Bun

## Setup

1. Clone the repository
2. Run `make next-setup` to install the required dependencies
3. Run `make db-setup` to setup the database

## How to run

- Backend: `make go-run` or `make go-run-dev` for hot reloading
- Frontend: `make next-run`
- Generating proto types from .proto files: `make generate-proto`

## Other goodies

- Run `make db-data-erase` to delete all data from the database. 


## HOWTO Guides

### How to add a new API endpoint

1. Add a service in the `proto` folder.
2. Generate the proto types by running `make generate-proto`. (If you are using LSPs, you should reload them to get the new types)
3. Implement the service in the `backend/servers` folder and add the service to the main.go file.
4. Add the endpoint to tRPC in the `frontend/src/server/api/routers` folder.
5. Use the endpoint in the frontend.

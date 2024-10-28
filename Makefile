PROTO_DIR := ./proto
GO_OUT_DIR := ./protogen/golang
TS_OUT_DIR := ./protogen/typescript

PROTOC_GEN_TS_PATH := F:/Projects/Go/api/node_modules/.bin/protoc-gen-ts.cmd
PROTOC_GEN_GRPC_PATH := F:/Projects/Go/api/node_modules/.bin/grpc_tools_node_protoc_plugin.cmd

proto: generate_go generate_ts

generate_go:
	protoc -I=$(PROTO_DIR) --go_out=$(GO_OUT_DIR) --go_opt=paths=source_relative \
		--go-grpc_out=$(GO_OUT_DIR) --go-grpc_opt=paths=source_relative \
		--grpc-gateway_out=$(GO_OUT_DIR) --grpc-gateway_opt paths=source_relative \
		--grpc-gateway_opt generate_unbound_methods=true \
		$(PROTO_DIR)/**/*.proto

generate_ts:
	protoc -I=$(PROTO_DIR) --plugin=protoc-gen-ts=$(PROTOC_GEN_TS_PATH) --grpc_out=grpc_js:$(TS_OUT_DIR) $(PROTO_DIR)/**/*.proto
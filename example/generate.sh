#!/usr/bin/env bash

go build -v ../main.go 
#protoc --plugin=protoc-gen-custom=./main --custom_out=dart_client service.proto


# protoc -I . --twirp_out=go --go_out=paths=source_relative:go config/model/model.proto
# protoc -I . --twirp_out=go --go_out=go config/service/service.proto

#protoc -I . --twirp-dart_out=dart_client config/service/service.proto

protoc -I. --plugin=protoc-gen-custom=./main --custom_out=dart_client --dart_out=dart_client config/model/model.proto 
protoc -I. --plugin=protoc-gen-custom=./main --custom_out=dart_client --dart_out=dart_client config/service/service.proto 
protoc -I$PROTO_DIR --dart_out=dart_client $PROTO_DIR/google/protobuf/timestamp.proto

dartfmt -w \
    ./dart_client/config/model/model.twirp.dart \
    ./dart_client/config/service/service.twirp.dart

#dartfmt -w dart_client/service.dart
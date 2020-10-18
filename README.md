# Twirp Dart Plugin

A protoc plugin for generating a twirp client suitable for web and flutter/io projects. Inspired by the [Twirp typescript plugin](https://github.com/larrymyers/protoc-gen-twirp_typescript).

## Setup

The protobuf v3 compiler is required. You can get the latest precompiled binary for your system here:

https://github.com/google/protobuf/releases

### Twirp Go Server (optional)

While not required for generating the client code, it is required to run the server component of the example.

    go get github.com/twitchtv/twirp/protoc-gen-twirp
    go get -u github.com/golang/protobuf/protoc-gen-go

### Dependencies

This plugin requires 3 Dart pub dependencies. In your pubspec.yaml specify:
http: ^0.11.0
requester: ">=0.0.2 <2.0.0"
protobuf: ^1.0.1

## Usage

    go get -u github.com/pellegrino/protoc-gen-twirp_dart
    pub global activate protoc_plugin
    protoc --dart_out=./example/dart_client --twirp_dart_out=./example/dart_client ./example/go/rpc/example/service.proto

All generated files will be placed relative to the specified output directory for the plugin.  
This is different behavior than the twirp Go plugin, which places the files relative to the input proto files.

This decision is intentional, since only client code is generated, and the destination is likely somewhere different
than the server code.

In order to support google.protobuf.Timestamp fields, you need to generate the dart code separetely.

See: [https://github.com/grpc/grpc-dart/issues/76#issuecomment-376875595]

```
# PROTO_DIR is the directory where the protobuf compiler has been installed

protoc -I$PROTO_DIR --dart_out=example/dart_client $PROTO_DIR/google/protobuf/timestamp.proto

```

Using the Twirp hashberdasher proto:

```dart
Future main(List<String> args) async {
  var service = new DefaultHaberdasher('http://localhost:8080');
  try {
    var hat = await service.makeHat(new Size()..inches = 10);
    print(hat);

    hat = await service.makeHat(new Size()..inches = -1);
    print(hat);
  } on TwirpJsonException catch (e) {
    print("${e.code} - ${e.message}");
  } catch (e) {
    print(e);
  }
}
```

### Parameters

The plugin parameters should be added in the same manner as other protoc plugins.
Key/value pairs separated by a single equal sign, and multiple parameters comma separated.

## Using the Example

Run the server:

    make run
    go run cmd/haberdasher/main.go

In a new terminal run the client:

    cd example/dart_client
    pub get
    dart main.dart

import 'dart:async';
import 'dart:ffi';

import 'config/model/model.twirp.dart';
import 'config/service/service.twirp.dart';
import 'package:fixnum/fixnum.dart';

Future main(List<String> args) async {
  var service = new ProtobufHaberdasher('http://localhost:9000');
  try {
    var hat = await service.makeHat(new Size(10));
    print(hat);

    hat.dictionary["Test"] = Int64(123121);
    hat.dictionary["Test2"] = Int64(23);
    hat.createdOn = new DateTime.now();
    hat.dictionaryWithMessage["BackupSize"] = new Size(20);
    var boughtHat = await service.buyHat(hat);
    print(boughtHat);
  } on Exception catch (e) {
    print("${e.toString()}");
  } catch (e) {
    print(e);
  }
}

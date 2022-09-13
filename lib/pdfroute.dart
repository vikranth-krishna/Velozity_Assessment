import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

Future<void> saveandlaunchfile(List<int> bytes, String filename) async {
  var status = await Permission.storage.isGranted;
  final appDoc = (await getExternalStorageDirectory())!.path;
  final file = File('$appDoc/$filename');
  await file.writeAsBytes(bytes, flush: true);
  final da = OpenFile.open('$appDoc/$filename');
  Share.shareFiles(['${appDoc}/$filename']);
}

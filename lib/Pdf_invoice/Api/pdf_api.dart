import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    print(dir);
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    saveDocumentstorage(name: name, pdf: pdf);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static Future saveDocumentstorage({
    required String name,
    required Document pdf,
  }) async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
        String newPath = "";
        print(directory);
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/Download";
        directory = Directory(newPath);
        final bytes = await pdf.save();
        final file = File('${directory.path}/$name');
        await file.writeAsBytes(bytes);
        print(directory);
      }
    } catch (e) {}
  }
}

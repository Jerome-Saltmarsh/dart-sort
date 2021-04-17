/***
 * HTPL - HYPER TEXT PROGRAMMING LANGUAGE
 *
 * Hypertext progamming language is a computer programming language designed
 * by Jerome Saltmarsh (30) on the April 17 of 2021.
 *
 * The point of the language is enable developers to
 */

import 'dart:io';
import 'dart:convert';

class Htpl {
  List<Text> children;
}

class Text {
  final String value;

  Text(this.value);
}


String line1 = '<text: "hello world">';

void main(List<String> arguments) async {
  // read in the file .htpl
  // parse it and create a writer
  // save file to file system as hello_world.html
  final helloFilePath = 'C:/Users/Jerome/github/dart-sort/hello.htpl';
  final readFilePath = helloFilePath;
  final File readFile = File(readFilePath);
  final List<String> readFileLines = [];

  print("importing $helloFilePath");
  String writeContent = "";
  await readFile
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .forEach((line) {
    readFileLines.add(line);
    print('line added: $line');

    if(line.startsWith('<text')){
      writeContent = 'text directive detected';
    }
  });

  print("imported ${readFile.path}");


  // readFile.readAsString().then((String contents) {
  //   print('contents: $contents');
  // });


  final writeFileName = readFile.path.replaceAll('htpl', 'html');
  final writeFile = File(writeFileName);
  final writtenFile = await writeFile.writeAsString(writeContent);
  print('exported ${writeFile.absolute.path}');

}

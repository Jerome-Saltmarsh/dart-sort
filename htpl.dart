/***
 * HTPL - HYPER TEXT PROGRAMMING LANGUAGE
 *
 * Hypertext progamming language is a computer programming language designed
 * by Jerome Saltmarsh (30) on the April 17 of 2021.
 *
 * The point of the language is enable developers to
 */


import 'dart:async';
import 'dart:io';
import 'dart:convert';

String line1 = '<text: "hello world">';

void main() async {
  // read in the file .htpl
  // parse it and create a writer
  // save file to file system as hello_world.html
  final path = 'C:/Users/Jerome/github/dart-sort/hello.htpl';
  final File readFile = File(path);
  final List<String> lines = [];
  readFile
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .forEach((line) {
    lines.add(line);
    print('line added: $line');
  });
  readFile.readAsString().then((String contents) {
    print('contents: $contents');
  });


  final writeFile = File('exported.html');
  final writtenFile = await writeFile.writeAsString('some content');
  var sink = writeFile.openWrite();
  sink.write('FILE ACCESSED ${DateTime.now()}\n');
  // Close the IOSink to free system resources.
  sink.close();

}

void import() {

}

void export() {

}

void generate() {
  // read in a file
  // import a html script
  // write out to a new file
  // export html script object to html, js and css files
}
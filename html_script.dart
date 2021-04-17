import 'dart:async';
import 'dart:io';
import 'dart:convert';

String line1 = '<text: "hello world">';

void main() {
  // read in the file .htpl
  // parse it and create a writer
  // save file to file system as hello_world.html
  var path = 'C:/Users/Jerome/github/dart-sort/hello.htpl';
  new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((l) {
    print('line: $l');
  });
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
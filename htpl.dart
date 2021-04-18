/***
 * HTPL - HYPER TEXT PROGRAMMING LANGUAGE
 *
 * Hypertext progamming language is a computer programming language designed
 * by Jerome Saltmarsh (30) on the April 17 of 2021.
 *
 * The point of the language is enable developers to write elegent code for the web
 *
 * html is not elegent
 */
import 'dart:io';
import 'dart:convert';


void main(List<String> arguments) async {
  final helloFilePath = 'C:/Users/Jerome/github/dart-sort/hello.htpl';
  final readFilePath = helloFilePath;
  final File readFile = File(readFilePath);
  final String nl = '\n';
  String writeContent = "";
  final String empty = "";
  writeContent += "<html>";
  print("reading ${readFile.path}");
  await readFile
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .forEach((line) {
    if(line.startsWith('<text')){
      final lineValue = line
          .replaceAll("<text", empty)
          .replaceAll(">", empty);
          // .replaceAll("\'", empty);

      List<String> parts = lineValue.split(" ");
      // Map<String, dynamic> attributes = Map();
      // parts.forEach((part){
      //   List<String> subParts = part.split(":");
      //   attributes[subParts[0]] = subParts[1];
      // });

      // "style=color:blue;
      String attributeString = "onclick=\"printHelloWorld()\"";
      String div = '<div $attributeString>';
      div += nl;
      div += lineValue;
      div += nl;
      div += "</div>";
      writeContent += div;
    }
  });
  writeContent += "</html>";
  writeContent += "<script>";
  writeContent += 'function printHelloWorld() {';
  // writeContent += 'document.getElementById("demo").innerHTML = "YOU CLICKED ME!";';
  writeContent += 'console.log("hello");';
  writeContent += 'alert("hello");';
  writeContent += '}';
  writeContent += "</script>";
  final writeFileName = readFile.path.replaceAll('htpl', 'html');
  final writeFile = File(writeFileName);
  await writeFile.writeAsString(writeContent);
  print('writing ${writeFile.absolute.path}');
  print(writeContent);
}

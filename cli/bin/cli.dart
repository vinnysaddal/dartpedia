import 'dart:io';
import 'package:http/http.dart' as http;

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
  } else if (arguments.first == 'version'){
  print('Dartpedia CLI version $version');
  } else if (arguments.first == 'wikipedia') {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null; // '?' - ternary conditional "operator condition ? valueIfTrue : valueIfFalse"
    searchWikipedia(inputArgs);
  } else {
    printUsage();
  }
}

void searchWikipedia(List<String>? arguments) async { // ? means that arguments list can be null
  final String articleTitle;

  // If user doesnt pass in args, request article title
  if (arguments == null || arguments.isEmpty){
    print('please provide an article title.');
    final inputFromStdin = stdin.readLineSync(); // Read input
    if (inputFromStdin == null || inputFromStdin.isEmpty){
      print('no article title provided. exiting.');
      return; // exits the function if no valid input
    }
    articleTitle = inputFromStdin; 
  } else {
    // otherwise join arguments to single string
    articleTitle = arguments.join(' ');
  }

  print('looking up articles about "$articleTitle". please wait.');

  // call API and await the result
  var articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent);
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'wikipedia <ARTICLE-TITLE>'"
  );
}

Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org', // Wikipedia API domain
    '/api/rest_v1/page/summary/$articleTitle', // API path for article summary
  );
  final response = await http.get(url); // make the HTTP request and wait till it returns object

  if (response.statusCode == 200){
    return response.body; // Return response body if successful
  }

  // Return error message if request failed
  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}
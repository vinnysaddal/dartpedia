import 'dart:io';
const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
  } else if (arguments.first == 'version'){
  print('Dartpedia CLI version $version');
  } else if (arguments.first == 'search') {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else {
    printUsage();
  }
}

void searchWikipedia(List<String>? arguments){ // ? means that arguments list can be null
  final String articleTitle;

  // If user doesnt pass in args, request article title
  if (arguments == null || arguments.isEmpty){
    print('please provide an article title.');
    // Await input and provide a default empty string if input is null
    articleTitle = stdin.readLineSync() ?? ''; // ?? '' means that will provide empty string as fallback as input cannot be null
  } else {
    // otherwise join arguments to single string
    articleTitle = arguments.join(' ');
  }
  print('looking up articles about "$articleTitle". Please wait.');
  print('here ya go!');
  print('(pretend this is an article about "$articleTitle")');
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'"
  );
}
enum OptionType { flag, option }

abstract class Argument {
  String get name;
  String? get help;

  // in the case of flags, default value is bool.
  // in other options and commands, default is string.
  // flags are just Option objects that dont take arguments
  Object? get defaultValue;
  String? get valueHelp;
  
  String get usage;
}
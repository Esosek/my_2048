import 'package:logger/logger.dart';

class CustomLogger {
  CustomLogger(this.className)
      : _logger = Logger(
          printer: CustomLogPrinter(className),
        );

  final Logger _logger;
  final String className;

  // Detailed logs
  void trace(String message) => _logger.log(Level.trace, message);
  // Temporary dev helper logs
  void debug(String message) => _logger.log(Level.debug, message);
  // Information about flow
  void info(String message) => _logger.log(Level.info, message);
  // This might break something not critical
  void warning(String message) => _logger.log(Level.warning, message);
  // Key feature is broken
  void error(String message) => _logger.log(Level.error, message);
}

class CustomLogPrinter extends LogPrinter {
  CustomLogPrinter(this.className);

  final String className;

  final _prettyPrinter = PrettyPrinter(
      errorMethodCount: 3,
      methodCount: 0,
      lineLength: 50,
      levelColors: {
        ...PrettyPrinter.defaultLevelColors,
        Level.debug: const AnsiColor.fg(82)
      },
      levelEmojis: {
        ...PrettyPrinter.defaultLevelEmojis,
        Level.debug: '🌱',
        Level.info: '🔹',
        Level.warning: '🔸',
        Level.error: '🔥',
      });

  @override
  List<String> log(LogEvent event) {
    var color = _prettyPrinter.levelColors![event.level];
    var emoji = _prettyPrinter.levelEmojis![event.level];
    return [(color!('$emoji $className: ${event.message}'))];
  }
}

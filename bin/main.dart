import 'dart:io';

import 'package:colorize/colorize.dart';
import 'package:nyxx/nyxx.dart';
import 'package:dotenv/dotenv.dart' as dotenv show load;
import 'package:nyxx_commands/nyxx_commands.dart';

import 'commands/start.dart';
import 'constants.dart';

void main(List<String> arguments) {
  dotenv.load();

  if (kbotToken == null) {
    stderr.writeln(
      Colorize('BOT_TOKEN in .env file not found').red(),
    );
    exit(1);
  }

  final bot = NyxxFactory.createNyxxWebsocket(
    kbotToken!,
    GatewayIntents.allUnprivileged,
    ignoreExceptions: false,
  );

  bot.eventsWs.onReady.listen((_readyEvent) {
    stdout.writeln(
      Colorize('Logged in as ${bot.self.tag}').green(),
    );
  });

  final commands = CommandsPlugin(
    prefix: (_) => "\$",
  );

  commands.registerChild(
    Command.textOnly(
      'start',
      'Starts the server',
      start,
    ),
  );

  bot.registerPlugin(commands);
  bot.connect();
}

import 'dart:io';

import 'package:colorize/colorize.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:process_run/shell.dart';

import 'package:dotenv/dotenv.dart' as dotenv show env;

import '../constants.dart';

Future<void> start(Context ctx) async {
  final shellCommandRunner = Shell(
    stdin: broadcastedStdin,
    commandVerbose: false,
    throwOnError: false,
    environment: dotenv.env,
  );

  final serverStartScript = dotenv.env['SERVER_START_SCRIPT'];

  if (serverStartScript == null) {
    stderr.writeln(
      Colorize('SERVER_START_SCRIPT not found in .env').red(),
    );

    await ctx.send(MessageBuilder.content('Sorry, there was an error'));
    return;
  } else if (serverStartScript.isEmpty) {
    stderr.writeln(
      Colorize('SERVER_START_SCRIPT cannot be empty!').red(),
    );
    ctx.send(MessageBuilder.content('Sorry, there was an error'));
    return;
  }

  await shellCommandRunner.run(serverStartScript);
}

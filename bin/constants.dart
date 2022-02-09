import 'dart:io';

import 'package:dotenv/dotenv.dart' as dotenv show env;

final kbotToken = dotenv.env['BOT_TOKEN'];

final broadcastedStdin = stdin.asBroadcastStream();

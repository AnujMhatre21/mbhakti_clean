// import 'dart:io';
// import 'package:ffmpeg_kit_flutter_min_gpl/ffmpeg_kit.dart';
// import '../models/template.dart';

// class FFmpegService {
//   static Future<bool> compose({
//     required String baseVideo,
//     required String music,
//     required List<String> userImages,
//     required List<PlaceholderSlot> slots,
//     required Duration duration,
//     required String outPath,
//     int fps = 30, String preset = 'veryfast', int bitrateK = 3500, int audioK = 128,
//   }) async {
//     try {
//       final inputs = StringBuffer("-y -i '$baseVideo' ");
//       for (final img in userImages) inputs.write("-i '$img' ");
//       inputs.write("-i '$music' ");

//       final fc = StringBuffer();
//       String current = '[0:v]';
//       for (int i=0; i<slots.length && i<userImages.length; i++) {
//         final s = slots[i];
//         final next = (i == slots.length - 1 || i == userImages.length - 1) ? 'vout' : 'v$i';
//         fc.write("$current[${i+1}:v] overlay=x=W*${s.x}:y=H*${s.y}:enable='between(t,${s.inSec},${s.outSec})' [$next];");
//         current = '[$next]';
//       }
//       final chain = fc.toString();
//       final filterPart = chain.isEmpty ? "" : "-filter_complex \"${chain.substring(0, chain.length - 1)}\"";

//       final cmd = [
//         inputs.toString(),
//         if (filterPart.isNotEmpty) filterPart,
//         "-map '$current'",
//         "-map ${userImages.length + 1}:a",
//         "-r $fps -preset $preset -b:v ${bitrateK}k -b:a ${audioK}k",
//         "-movflags +faststart",
//         "'$outPath'",
//       ].join(' ');

//       final session = await FFmpegKit.execute(cmd);
//       final rc = await session.getReturnCode();
//       return rc?.isValueSuccess() == true && File(outPath).existsSync();
//     } catch (_) { return false; }
//   }
// }

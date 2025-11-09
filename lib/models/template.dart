class TemplateModel {
  final String id, name, deity, thumbUrl;
  final double durationS;
  final String videoUrl, musicUrl, placeholderConfigUrl;
  TemplateModel({
    required this.id, required this.name, required this.deity, required this.thumbUrl,
    required this.durationS, required this.videoUrl, required this.musicUrl, required this.placeholderConfigUrl,
  });
}
class PlaceholderSlot {
  final int id; final double x,y,w,h,inSec,outSec; final double radius; final String fit;
  const PlaceholderSlot({required this.id, required this.x, required this.y, required this.w, required this.h,
    required this.inSec, required this.outSec, this.radius=0, this.fit='cover'});
  factory PlaceholderSlot.fromJson(Map<String,dynamic> j)=> PlaceholderSlot(
    id:j['id'], x:(j['x'] as num).toDouble(), y:(j['y'] as num).toDouble(),
    w:(j['w'] as num).toDouble(), h:(j['h'] as num).toDouble(),
    inSec:(j['in'] as num).toDouble(), outSec:(j['out'] as num).toDouble(),
    radius:(j['radius']??0).toDouble(), fit:(j['fit']??'cover'),
  );
}

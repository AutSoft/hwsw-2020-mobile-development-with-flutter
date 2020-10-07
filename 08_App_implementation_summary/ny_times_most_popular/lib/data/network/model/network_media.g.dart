// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkMedia _$NetworkMediaFromJson(Map<String, dynamic> json) {
  return NetworkMedia(
    json['type'] as String,
    json['caption'] as String,
    (json['media-metadata'] as List)
        ?.map((e) => e == null
            ? null
            : NetworkMediaMetadata.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NetworkMediaToJson(NetworkMedia instance) =>
    <String, dynamic>{
      'type': instance.type,
      'caption': instance.caption,
      'media-metadata': instance.metadata,
    };

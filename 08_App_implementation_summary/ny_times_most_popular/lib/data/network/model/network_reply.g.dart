// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkReply _$NetworkReplyFromJson(Map<String, dynamic> json) {
  return NetworkReply(
    (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : NetworkArticle.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NetworkReplyToJson(NetworkReply instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

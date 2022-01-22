import 'dart:convert';


List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  String? id;
  String? userId;
  String? accessModifier;
  String? content;
  String? imgaeUrl;
  int? likeCount;
  int? commentCount;
  String? time;
  Post({
    this.id,
    this.userId,
    this.accessModifier,
    this.content,
    this.imgaeUrl,
    this.likeCount,
    this.commentCount,
    this.time,
  });

  Post copyWith({
    String? id,
    String? userId,
    String? accessModifier,
    String? content,
    String? imgaeUrl,
    int? likeCount,
    int? commentCount,
    String? time,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      accessModifier: accessModifier ?? this.accessModifier,
      content: content ?? this.content,
      imgaeUrl: imgaeUrl ?? this.imgaeUrl,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'accessModifier': accessModifier,
      'content': content,
      'imgaeUrl': imgaeUrl,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'time': time,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      userId: map['userId'],
      accessModifier: map['accessModifier'],
      content: map['content'],
      imgaeUrl: map['imageUrl'],
      likeCount: map['likeCount']?.toInt(),
      commentCount: map['commentCount']?.toInt(),
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(id: $id, userId: $userId, accessModifier: $accessModifier, content: $content, imgaeUrl: $imgaeUrl, likeCount: $likeCount, commentCount: $commentCount, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Post &&
      other.id == id &&
      other.userId == userId &&
      other.accessModifier == accessModifier &&
      other.content == content &&
      other.imgaeUrl == imgaeUrl &&
      other.likeCount == likeCount &&
      other.commentCount == commentCount &&
      other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      accessModifier.hashCode ^
      content.hashCode ^
      imgaeUrl.hashCode ^
      likeCount.hashCode ^
      commentCount.hashCode ^
      time.hashCode;
  }
}

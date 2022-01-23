import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromMap(x)));

class User {
  String? id;
  String? phone;
  String? fullName;
  int? height;
  String? avatar;
  String? sex;
  int? age;
  String? job;
  String? income;
  String? marriage;
  String? children;
  String? home;
  String? zodiac;
  String? status;
  String? formality;
  String? linkFb;
  String? linkIs;
  String? zlPhone;
  String? address;
  String? target;
  String? about;
  int? countLike;
  int? countFollowing;
  int? countFollower;
  String? err;
  String? token;
  User({
    this.id,
    this.phone,
    this.fullName,
    this.height,
    this.avatar,
    this.sex,
    this.age,
    this.job,
    this.income,
    this.marriage,
    this.children,
    this.home,
    this.zodiac,
    this.status,
    this.formality,
    this.linkFb,
    this.linkIs,
    this.zlPhone,
    this.address,
    this.target,
    this.about,
    this.countLike,
    this.countFollowing,
    this.countFollower,
    this.err,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'fullName': fullName,
      'height': height,
      'avatar': avatar,
      'sex': sex,
      'age': age,
      'job': job,
      'income': income,
      'marriage': marriage,
      'children': children,
      'home': home,
      'zodiac': zodiac,
      'status': status,
      'formality': formality,
      'linkFb': linkFb,
      'linkIs': linkIs,
      'zlPhone': zlPhone,
      'address': address,
      'target': target,
      'about': about,
      'countLike': countLike,
      'countFollowing': countFollowing,
      'countFollower': countFollower,
      'message': err,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      phone: map['phone'],
      fullName: map['fullName'],
      height: map['height']?.toInt(),
      avatar: map['avatar'],
      sex: map['sex'],
      age: map['age']?.toInt(),
      job: map['job'],
      income: map['income'],
      marriage: map['marriage'],
      children: map['children'],
      home: map['home'],
      zodiac: map['zodiac'],
      status: map['status'],
      formality: map['formality'],
      linkFb: map['linkFb'],
      linkIs: map['linkIs'],
      zlPhone: map['zlPhone'],
      address: map['address'],
      target: map['target'],
      about: map['about'],
      countLike: map['countLike']?.toInt(),
      countFollowing: map['countFollowing']?.toInt(),
      countFollower: map['countFollower']?.toInt(),
      err: map['message'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? phone,
    String? fullName,
    int? height,
    String? avatar,
    String? sex,
    int? age,
    String? job,
    String? income,
    String? marriage,
    String? children,
    String? home,
    String? zodiac,
    String? status,
    String? formality,
    String? linkFb,
    String? linkIs,
    String? zalo,
    String? address,
    String? target,
    String? about,
    int? like,
    int? following,
    int? follower,
    String? err,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      height: height ?? this.height,
      avatar: avatar ?? this.avatar,
      sex: sex ?? this.sex,
      age: age ?? this.age,
      job: job ?? this.job,
      income: income ?? this.income,
      marriage: marriage ?? this.marriage,
      children: children ?? this.children,
      home: home ?? this.home,
      zodiac: zodiac ?? this.zodiac,
      status: status ?? this.status,
      formality: formality ?? this.formality,
      linkFb: linkFb ?? this.linkFb,
      linkIs: linkIs ?? this.linkIs,
      zlPhone: zalo ?? zlPhone,
      address: address ?? this.address,
      target: target ?? this.target,
      about: about ?? this.about,
      countLike: like ?? countLike,
      countFollowing: following ?? countFollowing,
      countFollower: follower ?? countFollower,
      err: err ?? this.err,
      token: token ?? this.token,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, phone: $phone, fullName: $fullName, height: $height, avatar: $avatar, sex: $sex, age: $age, job: $job, income: $income, marriage: $marriage, children: $children, home: $home, zodiac: $zodiac, status: $status, formality: $formality, linkFb: $linkFb, linkIs: $linkIs, zalo: $zlPhone, address: $address, target: $target, about: $about, like: $countLike, following: $countFollowing, follower: $countFollower, err: $err, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.phone == phone &&
        other.fullName == fullName &&
        other.height == height &&
        other.avatar == avatar &&
        other.sex == sex &&
        other.age == age &&
        other.job == job &&
        other.income == income &&
        other.marriage == marriage &&
        other.children == children &&
        other.home == home &&
        other.zodiac == zodiac &&
        other.status == status &&
        other.formality == formality &&
        other.linkFb == linkFb &&
        other.linkIs == linkIs &&
        other.zlPhone == zlPhone &&
        other.address == address &&
        other.target == target &&
        other.about == about &&
        other.countLike == countLike &&
        other.countFollowing == countFollowing &&
        other.countFollower == countFollower &&
        other.err == err &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        phone.hashCode ^
        fullName.hashCode ^
        height.hashCode ^
        avatar.hashCode ^
        sex.hashCode ^
        age.hashCode ^
        job.hashCode ^
        income.hashCode ^
        marriage.hashCode ^
        children.hashCode ^
        home.hashCode ^
        zodiac.hashCode ^
        status.hashCode ^
        formality.hashCode ^
        linkFb.hashCode ^
        linkIs.hashCode ^
        zlPhone.hashCode ^
        address.hashCode ^
        target.hashCode ^
        about.hashCode ^
        countLike.hashCode ^
        countFollowing.hashCode ^
        countFollower.hashCode ^
        err.hashCode ^
        token.hashCode;
  }
}

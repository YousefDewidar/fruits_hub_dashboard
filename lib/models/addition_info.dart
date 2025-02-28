class AdditionInfo {
  final String? dateExpired;
  final String? calary;
  AdditionInfo({
    this.dateExpired,
    this.calary,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'dateExpired': dateExpired,
      'calary': calary,
    };
  }

  factory AdditionInfo.fromJson(Map<String, dynamic> map) {
    return AdditionInfo(
      dateExpired: map['date_expired'] as String?,
      calary: map['calary'] as String?,
    );
  }
}

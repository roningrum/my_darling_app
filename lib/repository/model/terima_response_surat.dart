class SuccessMessageResponse {
  SuccessMessageResponse({
      this.success, 
      this.message,});

  SuccessMessageResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  int? success;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}
class ApiAuthorizationResponseModel {
  
  ApiAuthorizationResponseModel({
    
    String? remark,
    String? status,
    String? message
  }){
    _remark = remark;
    _status = status;
    _message = message;
  }

  ApiAuthorizationResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'];
  }
  
  String? _remark;
  String? _status;
  String? _message;

  String? get remark => _remark;
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}
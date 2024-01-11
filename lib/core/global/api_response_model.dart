class ApiResponseModel {
  final int _statusCode;
  final String _message;
  final String _responseJson;

  ApiResponseModel(this._statusCode, this._message, this._responseJson);

  String get message => _message;
  String get responseJson => _responseJson;
  int get statusCode => _statusCode;
}

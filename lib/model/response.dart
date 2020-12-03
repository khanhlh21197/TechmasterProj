class APIResponse {
  String code;
  String message;
  String data;

  APIResponse({this.code, this.message, this.data});

  factory APIResponse.fromJson(Map<dynamic, dynamic> json) {
    return APIResponse(
      code: 'code',
      message: 'message',
      data: 'data',
    );
  }
}

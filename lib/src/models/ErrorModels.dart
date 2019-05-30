class ErrorModels{
  int statusCode;
  String statusMessage;

  ErrorModels({
    this.statusCode,
    this.statusMessage,
  });

  factory ErrorModels.fromJson(Map<String, dynamic> json) => new ErrorModels(
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
  };
}
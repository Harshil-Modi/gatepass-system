class RequestStatus {
  static String REQUEST_STATUS_APPROVED = "approved";
  static String REQUEST_STATUS_PENDING = "pending";
  static String REQUEST_STATUS_REJECTED = "rejected";
}

class Request {
  String id;
  String requestStatus;
  String reason;
  String leaveDateAndTime;
  String returnDateAndTime;

  Request({
    this.id,
    this.requestStatus,
    this.reason,
    this.leaveDateAndTime,
    this.returnDateAndTime,
  });
}

Request request;

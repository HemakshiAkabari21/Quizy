class DownloadLedger {
  bool? status;
  String? pdfUrl;
  String? message;

  DownloadLedger({this.status, this.pdfUrl, this.message});

  DownloadLedger.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pdfUrl = json['pdf_url'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['pdf_url'] = this.pdfUrl;
    data['message'] = this.message;
    return data;
  }
}
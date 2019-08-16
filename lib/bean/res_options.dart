class ResOptions {
  int id;
  dynamic data;
  int statusCode;
  DateTime responseTime; //ms
  int duration; //ms
  ResOptions({
    this.id,
    this.data,
    this.statusCode,
    this.responseTime,
    this.duration,
  });
}

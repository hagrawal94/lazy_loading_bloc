class Item {
  int id;
  String name;
  int teacherId;
  String description;
  String lastSubmittedDate;
  int marks;
  String attachFileName;
  String attachFilePath;
  bool publish;
  int tenant;
  List<int> batches;

  Item(
      {this.id,
        this.name,
        this.teacherId,
        this.description,
        this.lastSubmittedDate,
        this.marks,
        this.attachFileName,
        this.attachFilePath,
        this.publish,
        this.tenant,
        this.batches});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    teacherId = json['teacherId'];
    description = json['description'];
    lastSubmittedDate = json['lastSubmittedDate'];
    marks = json['marks'];
    attachFileName = json['attachFileName'];
    attachFilePath = json['attachFilePath'];
    publish = json['publish'];
    tenant = json['tenant'];
    batches = json['batches'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['teacherId'] = this.teacherId;
    data['description'] = this.description;
    data['lastSubmittedDate'] = this.lastSubmittedDate;
    data['marks'] = this.marks;
    data['attachFileName'] = this.attachFileName;
    data['attachFilePath'] = this.attachFilePath;
    data['publish'] = this.publish;
    data['tenant'] = this.tenant;
    data['batches'] = this.batches;
    return data;
  }
}

// para facilitar o desenvolvimento dos json utlize o seguinte site
// https://javiercbk.github.io/json_to_dart/
// modelo para passar

class Iten {
  String title;
  bool done;

  Iten({this.title, this.done});

  Iten.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['done'] = this.done;
    return data;
  }
}

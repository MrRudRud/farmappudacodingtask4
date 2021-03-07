class Posts {
  final String id;
  final String judul;
  final String isi;

  Posts({
    this.id,
    this.judul,
    this.isi,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return new Posts(id: json['id'], judul: json['judul'], isi: json['isi']);
  }
}

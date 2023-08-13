class GameNews {
  String title;
  String thumb;
  Author author;
  Tag tag;
  String time;
  String desc;
  String key;

  GameNews({
    required this.title,
    required this.thumb,
    required this.author,
    required this.tag,
    required this.time,
    required this.desc,
    required this.key,
  });
}

enum Author { teoAriesda }

enum Tag { games }

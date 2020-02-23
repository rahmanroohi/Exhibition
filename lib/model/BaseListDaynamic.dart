class BaseListDaynamic {
  int s;
  String m;
  Map<String, dynamic> d;
  String c;

  BaseListDaynamic({
    this.s,
    this.m,
    this.d,
    this.c,
  });

  //for login request
  factory BaseListDaynamic.fromJson(Map<String, dynamic> json) {
    if (json["s"] == 1)
      return BaseListDaynamic(
        s: json["s"] /*Source.fromJson(json["source"])*/,
        m: json["m"],
        d: json["d"] as Map<String, dynamic>,
        c: json["c"],
      );
    else
      return BaseListDaynamic(
        s: json["s"] /*Source.fromJson(json["source"])*/,
        m: json["m"],
        d: null,
        c: json["c"],
      );
  }

  Map<String, dynamic> toJson() => {
    "s": s,
    "m": m,
    "d": d,
    "c": c,
  };
}

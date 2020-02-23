class BaseListDaynamicStandard {
  int s;
  String m;
  List<dynamic> d;
  String c;

  BaseListDaynamicStandard({
    this.s,
    this.m,
    this.d,
    this.c,
  });

  //for login request
  factory BaseListDaynamicStandard.fromJson(Map<String, dynamic> json) {
    if (json["s"] == 1)
      return BaseListDaynamicStandard(
        s: json["s"] /*Source.fromJson(json["source"])*/,
        m: json["m"],
        d: json["d"] as List<dynamic>,
        c: json["c"],
      );
    else
      return BaseListDaynamicStandard(
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

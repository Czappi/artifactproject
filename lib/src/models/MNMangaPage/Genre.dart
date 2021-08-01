import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final String name, id;

  const Genre(this.name, this.id);

  @override
  List<Object> get props => [name, id];

  static Genre? byId(String id) => genreIdMap[id];

  static Genre? fromLink(String link) {
    var regex = RegExp(r"genre-(.*[0-9])").firstMatch(link);
    if (regex != null && regex.groupCount > 0) {
      return genreIdMap[regex.group(1)];
    } else {
      return null;
    }
  }

  static const Genre action = Genre("#genre-action", "2");
  static const Genre fantasy = Genre("#genre-fantasy", "12");
  static const Genre manhwa = Genre("#genre-manhwa", "43");
  static const Genre romance = Genre("#genre-romance", "27");
  static const Genre sliceoflife = Genre("#genre-sliceoflife", "35");
  static const Genre adult = Genre("#genre-adult", "3");
  static const Genre genderblender = Genre("#genre-genderblender", "13");
  static const Genre martialarts = Genre("#genre-martialarts", "19");
  static const Genre schoollife = Genre("#genre-schoollife", "28");
  static const Genre smut = Genre("#genre-smut", "36");
  static const Genre adventure = Genre("#genre-adventure", "4");
  static const Genre harem = Genre("#genre-harem", "14");
  static const Genre mature = Genre("#genre-mature", "20");
  static const Genre scifi = Genre("#genre-scifi", "29");
  static const Genre sports = Genre("#genre-sports", "37");
  static const Genre comedy = Genre("#genre-comedy", "6");
  static const Genre historical = Genre("#genre-historical", "15");
  static const Genre mecha = Genre("#genre-mecha", "21");
  static const Genre seinen = Genre("#genre-seinen", "30");
  static const Genre supernatural = Genre("#genre-supernatural", "38");
  static const Genre cooking = Genre("#genre-cooking", "7");
  static const Genre horror = Genre("#genre-horror", "16");
  static const Genre medical = Genre("#genre-medical", "22");
  static const Genre shoujo = Genre("#genre-shoujo", "31");
  static const Genre tragedy = Genre("#genre-tragedy", "39");
  static const Genre doujinshi = Genre("#genre-doujinshi", "9");
  static const Genre isekai = Genre("#genre-isekai", "45");
  static const Genre mystery = Genre("#genre-mystery", "24");
  static const Genre shoujoai = Genre("#genre-shoujoai", "32");
  static const Genre webtoons = Genre("#genre-webtoons", "40");
  static const Genre drama = Genre("#genre-drama", "10");
  static const Genre josei = Genre("#genre-josei", "17");
  static const Genre oneshot = Genre("#genre-oneshot", "25");
  static const Genre shounen = Genre("#genre-shounen", "33");
  static const Genre yaoi = Genre("#genre-yaoi", "41");
  static const Genre ecchi = Genre("#genre-ecchi", "11");
  static const Genre manhua = Genre("#genre-manhua", "44");
  static const Genre psychological = Genre("#genre-psychological", "26");
  static const Genre shounenai = Genre("#genre-shounenai", "34");
  static const Genre yuri = Genre("#genre-yuri", "42");

  static const Map<String, Genre> genreIdMap = {
    "2": action,
    "12": fantasy,
    "43": manhwa,
    "27": romance,
    "35": sliceoflife,
    "3": adult,
    "13": genderblender,
    "19": martialarts,
    "28": schoollife,
    "36": smut,
    "4": adventure,
    "14": harem,
    "20": mature,
    "29": scifi,
    "37": sports,
    "6": comedy,
    "15": historical,
    "21": mecha,
    "30": seinen,
    "38": supernatural,
    "7": cooking,
    "16": horror,
    "22": medical,
    "31": shoujo,
    "39": tragedy,
    "9": doujinshi,
    "45": isekai,
    "24": mystery,
    "32": shoujoai,
    "40": webtoons,
    "10": drama,
    "17": josei,
    "25": oneshot,
    "33": shounen,
    "41": yaoi,
    "11": ecchi,
    "44": manhua,
    "26": psychological,
    "34": shounenai,
    "42": yuri,
  };
  static const List<Genre> genres = [
    action,
    fantasy,
    manhwa,
    romance,
    sliceoflife,
    adult,
    genderblender,
    martialarts,
    schoollife,
    smut,
    adventure,
    harem,
    mature,
    scifi,
    sports,
    comedy,
    historical,
    mecha,
    seinen,
    supernatural,
    cooking,
    horror,
    medical,
    shoujo,
    tragedy,
    doujinshi,
    isekai,
    mystery,
    shoujoai,
    webtoons,
    drama,
    josei,
    oneshot,
    shounen,
    yaoi,
    ecchi,
    manhua,
    psychological,
    shounenai,
    yuri,
  ];
}

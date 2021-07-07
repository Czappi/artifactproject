import 'package:artifactproject/src/api/ApiClient.dart';
import 'package:artifactproject/src/api/LoginData.dart';
import 'package:artifactproject/src/models/MNChapterPage.dart' as mn_chapter;
import 'package:artifactproject/src/models/MNLogin.dart' as mn_login;
import 'package:artifactproject/src/utils/Enums.dart';
import 'package:flutter/foundation.dart';
import 'package:artifactproject/src/models/MNMangaPage.dart' as mn_manga;
import 'package:artifactproject/src/models/MNMangaListPage.dart'
    as mn_mangalist;

import 'package:artifactproject/src/api/parse.dart' as parse;

class ManganatoAPI {
  static const String loginHandle = "https://user.manganelo.com/login_handle";
  static const String homeref =
      "https://user.manganelo.com/?l=manganato&re_l=login";
  static const String loginPageLink = "https://user.manganelo.com/login";
  static const String addBookmarkLink = "https://manganelo.com/setbookmark";
  static const String removeBookmarkLink =
      "https://manganato.com/removebookmark";
  static const String rateMangaLink = "https://manganelo.com/story_vote";
  static const String bookmarkPageLink = "https://manganato.com/bookmark";
  final ApiClient apiClient = ApiClient();

  String username = "";
  LoginData? loginData;

  Future<mn_manga.Manga> mangaPage(String url) async {
    var response = await apiClient.get(url);

    return compute(
      parse.parseMangaPage,
      {"responseBody": response.body, "href": url},
    );
  }

  Future<mn_chapter.Chapter> chapterPage(String url) async {
    var response = await apiClient.get(url, pageSession: PageSession.readpage);

    return compute(
      parse.parseChapterPage,
      {"responseBody": response.body, "href": url},
    );
  }

  Future<List<mn_mangalist.MLElement>> mangaListPage(String url) async {
    var response = await apiClient.get(url);

    return compute(
      parse.parseMangaListPage,
      response.body,
    );
  }

  Future<List<mn_mangalist.MLElement>> search({
    SearchStatus status = SearchStatus.both,
    SearchOrderBy orderBy = SearchOrderBy.latest,
    SearchKeyword keyword = SearchKeyword.everything,
    List<mn_manga.Genre> genreInclude = const [],
    List<mn_manga.Genre> genreExclude = const [],
    String? search,
    int page = 1,
  }) async {
    String url = "https://manganato.com/advanced_search?s=all";

    // status
    switch (status) {
      case SearchStatus.both:
        break;
      case SearchStatus.completed:
        url + "&sts=completed";
        break;
      case SearchStatus.ongoing:
        url + "&sts=ongoing";
        break;
      default:
    }

    // orderBy
    switch (orderBy) {
      case SearchOrderBy.latest:
        break;
      case SearchOrderBy.az:
        url + "&orby=az";
        break;
      case SearchOrderBy.newest:
        url + "&orby=newest";
        break;
      case SearchOrderBy.topview:
        url + "&orby=topview";
        break;
      default:
    }

    // keyword, search
    if (search != null) {
      switch (keyword) {
        case SearchKeyword.everything:
          break;
        case SearchKeyword.nameTitle:
          url + "&keyt=title";
          break;
        case SearchKeyword.alternativeName:
          url + "&keyt=alternative";
          break;
        case SearchKeyword.author:
          url + "&keyt=author";
          break;
        default:
      }
      url + "&keyw=$search";
    }

    // genreInclude
    var genreIncludeIds = genreInclude.map((e) => e.id);
    if (genreIncludeIds.isNotEmpty) {
      String gIIdsString = genreIncludeIds.join("_");
      url + "&g_i=_${gIIdsString}_";
    }

    // genreExculde
    var genreExcludeIds = genreExclude.map((e) => e.id);
    if (genreExcludeIds.isNotEmpty) {
      String gEIdsString = genreExcludeIds.join("_");
      url + "&g_i=_${gEIdsString}_";
    }

    // page
    url + "&page=$page";

    return await mangaListPage(url);
  }

  /// returns the captcha picture's url
  /// and update the ciSession
  Future<mn_login.LoginPage?> loginPage() async {
    var response = await apiClient.get(loginPageLink);

    return await compute(parse.parseLoginPage, response.body);
  }

  Future<bool> responsivelogin(String username, String password, String captcha,
      String firstRedirectUrl) async {
    await apiClient.post(
      loginHandle + "?user=$username&pass=$password&captchar=$captcha",
    );

    // view-source:https://user.manganelo.com/?l=manganato&re_l=login
    // need to pass login data before go to this page
    var firstRedirectResponse = await apiClient.get(firstRedirectUrl);
    var secondRedirect = await compute(
        parse.parseLoginFirstRedirect, firstRedirectResponse.body);

    // view-source:https://manganato.com/login_al?u_t=bG9jYWw%3D&u_i={userid}&u_u={username}&u_a=LTE%3D&u_r=login_readmanganato_to_manganato
    if (secondRedirect != null) {
      var mainpageRedirect = await apiClient.get(secondRedirect);

      if (mainpageRedirect.isCiSessionUpdated) {
        var encryptedId =
            RegExp(r'u_i=([a-zA-Z0-9]+)').firstMatch(secondRedirect)!.group(1)!;
        var encryptedUsername =
            RegExp(r'u_u=([a-zA-Z0-9]+)').firstMatch(secondRedirect)!.group(1)!;
        loginData = LoginData(encryptedId, encryptedUsername);

        await apiClient.get(
            "https://readmanganato.com/login_al?u_t=bG9jYWw=&u_i=$encryptedId&u_u=$encryptedUsername&u_a=LTE=&u_r=manganato_home",
            pageSession: PageSession.readpage);

        this.username = username;
        return true;
      }
    }
    // view-source:https://readmanganato.com/login_al?u_t=bG9jYWw=&u_i={userid}&u_u={username}&u_a=LTE=&u_r=manganato_home
    // this not needed, the ciSession reset here goes to the oblivion xd (in my case atleast)

    return false;
  }

  Future<List<mn_login.Bookmark>> getBookmarks() async {
    List<mn_login.Bookmark> bookmarks = [];
    var nextPage = 1;
    var lastPage = 1;

    var firstResponse =
        await apiClient.get(bookmarkPageLink + "?page=$nextPage");
    var firstbookmarkpage =
        await compute(parse.parseBookmarkPage, firstResponse.body);

    bookmarks.addAll(firstbookmarkpage.bookmarks);

    nextPage = firstbookmarkpage.currentPage + 1;
    lastPage = firstbookmarkpage.lastPage;

    for (nextPage; nextPage <= lastPage; nextPage++) {
      var response = await apiClient.get(bookmarkPageLink + "?page=$nextPage");
      var bookmarkpage = await compute(parse.parseBookmarkPage, response.body);

      lastPage = bookmarkpage.lastPage;

      bookmarks.addAll(bookmarkpage.bookmarks);
    }

    return bookmarks;
  }

  Future<bool> addBookmark(String storyId) async {
    var response =
        await apiClient.post(addBookmarkLink, body: "storyid=$storyId");

    if (response.body == 'okie') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeBookmark(String bookmarkId) async {
    var response = await apiClient.post(removeBookmarkLink,
        body: "bookmarkid=$bookmarkId");

    if (response.body == 'okie') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> rateManga(int rating, String storyId) async {
    int _rating = rating.clamp(1, 5);
    var response = await apiClient.post(rateMangaLink,
        body: "rate=$_rating&idmanga=$storyId");
    if (response.body == 'ok') {
      return true;
    } else {
      return false;
    }
  }

  /// both id and username base64 encrypted
  Future<bool> loginWithId(String id, String username) async {
    String url =
        "https://manganato.com/login_al?u_t=bG9jYWw=&u_i=$id&u_u=$username&u_a=LTE=&u_r=manganato_home";

    var lastRedirect = await apiClient.get(url);

    if (lastRedirect.isCiSessionUpdated) {
      this.username = username;
      return true;
    } else {
      return false;
    }
  }

  // specified
  static const genreallPage = "https://manganato.com/genre-all/";

  Future<List<mn_mangalist.MLElement>> latestMangaPage(int page) async {
    return await mangaListPage(
      genreallPage + page.toString(),
    );
  }

  Future<List<mn_mangalist.MLElement>> hotMangaPage(int page) async {
    return await mangaListPage(
      genreallPage + page.toString() + "?type=topview",
    );
  }

  Future<List<mn_mangalist.MLElement>> newestMangaPage(int page) async {
    return await mangaListPage(
      genreallPage + page.toString() + "?type=newest",
    );
  }
}

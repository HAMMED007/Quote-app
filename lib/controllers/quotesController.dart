import 'package:get/get.dart';
import 'package:qoutes_app/controllers/user_controller.dart';
import 'package:qoutes_app/models/quote.dart';
import 'package:qoutes_app/services/database_service.dart';

class QuoteController extends GetxController {
  List<Quote> quotes = [];
  List<String> userFavouriteQoutesIDs = [];
  List<Quote> favouriteQuotes = [];
  String toDaysQuoteID = "";

  Quote currentQoute = Quote(quote: "", author: "", id: "");
  Quote toDaysQuote = Quote(quote: "", author: "", id: "");
  int currentQouteIndex = 0;

  final DatabaseService databaseService = DatabaseService();
  final UserController userController = Get.find(tag: "userController");

  init() async {
    quotes = await databaseService.fetchQuotes();
    toDaysQuoteID = await databaseService.fetchTodaysQuote();
    toDaysQuote =
        quotes.firstWhere((element) => element.id == toDaysQuoteID, orElse: () {
      return Quote(quote: "", author: "", id: "");
    });

    userFavouriteQoutesIDs =
        await databaseService.fetchFavouriteQuotes(userController.user.userID);
    if (quotes.isNotEmpty) {
      currentQoute = quotes[currentQouteIndex];
    }
    getFavouriteQoutesFromIDs();
    update();
  }

  getFavouriteQoutesFromIDs() {
    for (var i = 0; i < userFavouriteQoutesIDs.length; i++) {
      for (var j = 0; j < quotes.length; j++) {
        if (userFavouriteQoutesIDs[i] == quotes[j].id) {
          quotes[j].isFavourite = true;
          favouriteQuotes.add(quotes[j]);
        }
      }
    }
  }

  addFavouriteQoute() {
    userFavouriteQoutesIDs.add(quotes[currentQouteIndex].id);
    favouriteQuotes.add(quotes[currentQouteIndex]);
    update();
  }

  removeFavouriteQoute() {
    userFavouriteQoutesIDs.remove(currentQoute.id);
    favouriteQuotes.removeWhere((element) => element.id == currentQoute.id);
    update();
  }

  previousQoute() {
    if (currentQouteIndex > 0) {
      currentQouteIndex--;
    } else {
      currentQouteIndex = quotes.length - 1;
    }
    currentQoute = quotes[currentQouteIndex];
    print(currentQoute.id);

    update();
  }

  nextQoute() {
    if (currentQouteIndex < quotes.length - 1) {
      currentQouteIndex++;
    } else {
      currentQouteIndex = 0;
    }
    currentQoute = quotes[currentQouteIndex];
    print(currentQoute.id);

    update();
  }
}

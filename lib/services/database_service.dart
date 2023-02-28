import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qoutes_app/models/quote.dart';
import 'package:qoutes_app/models/user.dart';

class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Quote>> fetchQuotes() async {
    List<Quote> quotes = [];
    try {
      print("fetching quotes");
      QuerySnapshot<Map<String, dynamic>> docSnapshot =
          await firestore.collection('quotes').get();
      docSnapshot.docs.forEach((element) {
        print(element.data());
      });
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in docSnapshot.docs) {
        print(doc.id);
        quotes.add(Quote.fromJson(doc.data(), doc.id));
      }
    } catch (e) {
      print("error is " + e.toString());
    }
    print("quotes");
    return quotes;
  }

  addUser(User user) async {
    final docRef = firestore.collection("users").doc(user.userID);
    try {
      await docRef.set(user.toJson());
    } catch (e) {
      print("error is " + e.toString());
    }
  }

  String getUserProfilePic(String uid) {
    String profilePic = "";
    final docRef = firestore.collection("users").doc(uid);
    try {
      docRef.get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        profilePic = data["profilePictureLink"];
      });
    } catch (e) {}
    return profilePic;
  }

  fetchFavouriteQuotes(String userID) async {
    print("fetching favourite quotes");
    List<String> quoteIDs = [];
    final docRef = firestore.collection("favouriteQuotes").doc(userID);
    try {
      await docRef.get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print("fetched favourite quotes");

        print("DATA______" + data["quoteIDs"].toString());
        try {
          quoteIDs = data["quoteIDs"].cast<String>();
        } catch (e) {
          print("error is " + e.toString());
        }
        print(quoteIDs.length);
      });
    } catch (e) {}
    return quoteIDs;
  }

  Future<String> fetchTodaysQuote() async {
    print("fetching favourite quotes");
    String todaysQuote = "";
    final docRef = firestore.collection("quoteOfTheDay").doc("todaysQuote");
    try {
      await docRef.get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        try {
          todaysQuote = data["quoteID"];
          print("TODAYS QUOTE IS " + todaysQuote);
        } catch (e) {
          print("error is " + e.toString());
        }
      });
    } catch (e) {}
    return todaysQuote;
  }
}

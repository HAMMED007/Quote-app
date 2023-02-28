import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:qoutes_app/controllers/quotesController.dart';
import 'package:qoutes_app/views/styles.dart';
import 'package:qoutes_app/views/utils/app_locals.dart';
import 'package:qoutes_app/views/widgets/lang_switch.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isEng = true;
  QuoteController quoteController = Get.find(tag: 'quoteController');
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg_1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: 155,
                    child: Text(
                      AppLocale.quotesApp.getString(context),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                LangSwitch()
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    AppLocale.changeCategory.getString(context),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 12.0,
                        top: 42.0,
                      ),
                      child: Text(
                        quoteController.currentQoute.quote,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 12.0,
                        top: 42.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "-${quoteController.currentQoute.author}",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () => {
                            quoteController.currentQoute.isFavourite
                                ? quoteController.removeFavouriteQoute()
                                : quoteController.addFavouriteQoute(),
                            quoteController.currentQoute.isFavourite =
                                !quoteController.currentQoute.isFavourite,
                            setState(() {}),
                          },
                          icon: Icon(
                            quoteController.currentQoute.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: secondaryDarkColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () => {
                            Get.dialog(AlertDialog(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    " Share",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () => {Get.back()},
                                      icon: const Icon(Icons.cancel,
                                          color:
                                              Color.fromARGB(255, 68, 63, 63),
                                          size: 40))
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      child: Image.asset("assets/twitter.png"),
                                    ),
                                    CircleAvatar(
                                      child: Image.asset("assets/facebook.png"),
                                    ),
                                    CircleAvatar(
                                      child: Image.asset("assets/whatsapp.png"),
                                    ),
                                    CircleAvatar(
                                      child: Image.asset("assets/telegram.png"),
                                    ),
                                  ],
                                )
                              ],
                            ))
                          },
                          icon: Icon(
                            Icons.share,
                            color: secondaryDarkColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () =>
                          {quoteController.nextQoute(), setState(() {})},
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 5, color: Colors.black),
                          borderRadius:
                              BorderRadius.circular(100), //<-- SEE HERE
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Image.asset(
                            'assets/qoutes.png',
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            )
          ],
        ),
      ) /* add child content here */,
    );
  }
}

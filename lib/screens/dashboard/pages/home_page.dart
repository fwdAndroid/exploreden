import 'package:exploreden/screens/destination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CardSwiperController controller = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/filter.png", height: 20, width: 30),
          )
        ],
        title: Image.asset(
          "assets/owl.png",
          height: 40,
          width: 40,
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: CardSwiper(
                controller: controller,
                cardsCount: 5,
                onSwipe: _onSwipe,
                onUndo: _onUndo,
                numberOfCardsDisplayed: 3,
                backCardOffset: const Offset(40, 40),
                padding: const EdgeInsets.all(24.0),
                cardBuilder: (
                  context,
                  index,
                  horizontalThresholdPercentage,
                  verticalThresholdPercentage,
                ) =>
                    Column(
                      children: [
                        Image.asset("assets/unsplash_VVEwJJRRHgk.png"),
                      ],
                    )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: controller.swipeRight,
                  child: Image.asset(
                    "assets/cancel.png",
                    height: 60,
                    width: 60,
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.swipeLeft;

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => DestinationPage()));
                  },
                  child: Image.asset(
                    "assets/like.png",
                    height: 60,
                    width: 60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}

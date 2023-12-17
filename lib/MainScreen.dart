import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:imagetopdfconverter/classes/MainScreenAppBar.dart';
import 'package:imagetopdfconverter/classes/languageDialog.dart';
import 'package:imagetopdfconverter/widgets/drawer_widget.dart';
import 'package:imagetopdfconverter/widgets/mainOptions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? selectedOption;
  String? selectedCard;

  late final InterstitialAd interstitialAd;
  final String interstitialAdUnitId =
      "ca-app-pub-3940256099942544/1033173712"; //sample ad unit id

  //load ads
  @override
  void initState() {
    super.initState();

    //load ad here...
    _loadInterstitialAd();
  }

  //method to load an ad
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback:
          InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
        //keep a reference to the ad as you can show it later
        interstitialAd = ad;

        //set on full screen content call back
        _setFullScreenContentCallback();
      }, onAdFailedToLoad: (LoadAdError loadAdError) {
        //ad failed to load
        print("Interstitial ad failed to load: $loadAdError");
      }),
    );
  }

  //method to set show content call back
  void _setFullScreenContentCallback() {
    interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print("$ad onAdShowedFullScreenContent"),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print("$ad onAdDismissedFullScreenContent");

        //dispose the dismissed ad
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print("$ad  onAdFailedToShowFullScreenContent: $error ");
        //dispose the failed ad
        ad.dispose();
      },
      onAdImpression: (InterstitialAd ad) => print("$ad Impression occured"),
    );
  }

  //show ad method
  void _showInterstitialAd() {
    if (interstitialAd == null) {
      print("Ad not ready!");
      return;
    }
    interstitialAd.show();
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var useMobileLayout = shortestSide < 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: drawerWidget(context),
      appBar: MainScreenAppBarClass.getAppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 100),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: useMobileLayout
                ? Column(
                    children: [
                      mainOptionsTop(
                        context,
                        "Convert Image to PDF".tr,
                        "Use Now".tr,
                        const AssetImage("assets/gallery.png"),
                        const AssetImage("assets/pdficon.png"),
                        "1",
                      ),
                      mainOptionsTop(
                        context,
                        "Compress Images".tr,
                        "Use Now".tr,
                        const AssetImage("assets/gallery.png"),
                        const AssetImage("assets/compressicon.png"),
                        "2",
                      ),
                    ],
                  )
                : Column(
                    children: [
                      mainOptionsTopForTabs(
                        context,
                        "Convert Image to PDF".tr,
                        "Use Now".tr,
                        const AssetImage("assets/gallery.png"),
                        const AssetImage("assets/pdficon.png"),
                        "1",
                      ),
                      mainOptionsTopForTabs(
                        context,
                        "Compress Images".tr,
                        "Use Now".tr,
                        const AssetImage("assets/gallery.png"),
                        const AssetImage("assets/compressicon.png"),
                        "2",
                      ),
                    ],
                  ),
          ),
          SizedBox(
            height: 20,
          ),
          useMobileLayout
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mainOptionsBottom(
                      context,
                      "PDF Images".tr,
                      const AssetImage("assets/pdfcompletedicon.png"),
                      "3",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    mainOptionsBottom(
                      context,
                      "Compressed Images".tr,
                      const AssetImage("assets/compressImagescompleteIcon.png"),
                      "4",
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mainOptionsBottomForTabs(
                      context,
                      "PDF Images".tr,
                      const AssetImage("assets/pdfcompletedicon.png"),
                      "3",
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    mainOptionsBottomForTabs(
                      context,
                      "Compressed Images".tr,
                      const AssetImage("assets/compressImagescompleteIcon.png"),
                      "4",
                    ),
                  ],
                ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.language_rounded,
              size: 22,
            ),
            label: Text(
              "Change Language".tr,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "DM Sans",
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.black,
            ),
            onPressed: () {
              _showInterstitialAd();
              LanguageChangeDialog.buildDialog(context);
            },
          ),
        ]),
      ),
    );
  }
}

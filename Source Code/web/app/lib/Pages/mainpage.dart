import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtuallibrary/Pages/filelist.dart';
import 'package:virtuallibrary/Pages/uploadpage.dart';
import 'package:virtuallibrary/Widgets/card.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  double _currOffset = 0.0;
  void get _refresh => setState(() {});
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _imgHeight = MediaQuery.of(context).size.height;
    double _imageWidth = MediaQuery.of(context).size.width;
    const List<double> cardValueList1 = [-20, -70, -75, -160, -150, 600, 450];
    const List<double> cardValueList2 = [-5, -110, -115, -160, -150, 450, 350];
    return Scaffold(
      backgroundColor: const Color.fromRGBO(81, 72, 212, 1),
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Stack(
          children: [
            Positioned(
              top: -0.25 * _currOffset, // -ve as we want to scroll upwards
              child: Image.asset(
                "assets/images/background.png",
                fit: BoxFit.fitWidth,
                width: _imageWidth,
                height: _imgHeight,
              ),
            ),
            const SizedBox(width: double.infinity),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                ListView(
                  cacheExtent: 100.0,
                  addAutomaticKeepAlives: false,
                  controller: _scrollController,
                  children: <Widget>[
                    SizedBox(height: _imgHeight), // IMP STEP 1..
                    const SizedBox(
                      height: 300,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const UploadPage()));
                          },
                          child: _imageWidth > 840
                              ? const CardButton(
                                  cardText: "Upload",
                                  imageAdress: "assets/images/pdfbox.png",
                                  cardWidth: 280,
                                  cardHeight: 450,
                                  imageWidth: 500,
                                  imageHoverValue: cardValueList1,
                                )
                              : const CardButton(
                                  cardText: "Upload",
                                  imageAdress: "assets/images/pdfbox.png",
                                  cardWidth: 200,
                                  cardHeight: 300,
                                  imageWidth: 500,
                                  imageHoverValue: cardValueList2,
                                ),
                        ),
                        _imageWidth > 840
                            ? const SizedBox(
                                width: 300,
                              )
                            : const SizedBox(
                                width: 100,
                              ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const FileList()));
                          },
                          child: _imageWidth > 840
                              ? const CardButton(
                                  cardText: "File List",
                                  imageAdress: "assets/images/filelist.png",
                                  cardWidth: 280,
                                  cardHeight: 450,
                                  imageWidth: 500,
                                  imageHoverValue: cardValueList1,
                                )
                              : const CardButton(
                                  cardText: "File List",
                                  imageAdress: "assets/images/filelist.png",
                                  cardWidth: 200,
                                  cardHeight: 300,
                                  imageWidth: 500,
                                  imageHoverValue: cardValueList2,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      // print('>>>>>Scroll ${notification.scrollDelta}');
      _currOffset = notification.metrics.pixels;
    }

    _refresh;
    return false;
  }
}

import 'package:flutter/material.dart';

class CardButton extends StatefulWidget {
  final String cardText;
  final String imageAdress;
  final double cardHeight;
  final double cardWidth;
  final double imageWidth;
  final List<double> imageHoverValue;

  const CardButton({
    Key? key,
    required this.cardText,
    required this.imageAdress,
    required this.cardHeight,
    required this.cardWidth,
    required this.imageWidth,
    required this.imageHoverValue,
  }) : super(key: key);

  @override
  _CardButtonState createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  bool isHover = false;
  Offset mousePos = const Offset(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) {
        setState(() {
          isHover = true;
        });
      },
      onHover: (e) {
        setState(() {
          mousePos += e.delta;
          mousePos *= 0.12;
        });
      },
      onExit: (e) {
        setState(() {
          isHover = false;
        });
      },
      child: Container(
        height: widget.cardHeight, //450
        width: widget.cardWidth, //280
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: isHover ? 15 : 2,
              spreadRadius: isHover ? 5 : 2,
            ),
          ],
        ),
        child: Stack(
          children: [backImage(), gradient(), texts()],
        ),
      ),
    );
  }

  backImage() {
    return AnimatedPositioned(
      curve: Curves.easeOutCubic,
      top: isHover ? widget.imageHoverValue[0] + mousePos.dy : 0, // -20 : 0
      right: (widget.imageAdress.contains("filelist"))
          ? isHover
              ? widget.imageHoverValue[1] + mousePos.dx //-70
              : widget.imageHoverValue[2] // -75
          : isHover
              ? widget.imageHoverValue[3] + mousePos.dx // -160
              : widget.imageHoverValue[4], // -150
      duration: const Duration(microseconds: 1000),
      height: isHover
          ? widget.imageHoverValue[5]
          : widget.imageHoverValue[6], // 600, : 450
      width: widget.imageWidth, //500

      child: Container(
        width: widget.imageWidth, // 500
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage(widget.imageAdress),
          ),
        ),
      ),
    );
  }

  gradient() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
            colors: [
              Colors.black.withOpacity(isHover ? 0.8 : 0.0),
              Colors.transparent,
            ]),
      ),
    );
  }

  texts() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedDefaultTextStyle(
            child: Text(widget.cardText),
            style: TextStyle(
              color: Colors.white.withOpacity(isHover ? 1 : 0.6),
              fontSize: 25,
            ),
            duration: const Duration(milliseconds: 1000),
          ),
        ],
      ),
    );
  }
}

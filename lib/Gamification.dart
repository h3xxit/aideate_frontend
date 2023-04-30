import 'package:flutter/material.dart';
import 'package:watchat_ui/common/Score.dart';

import 'controller/reqController.dart';

class Gamification extends StatefulWidget {
  const Gamification(this.sessionId, this.setRatingListener, {Key? key}) : super(key: key);
  final void Function(void Function()) setRatingListener;
  final int? sessionId;

  @override
  _GamificationState createState() => _GamificationState();
}

class _GamificationState extends State<Gamification> {
  //List<Score> topThree;
  double avgScore = 0;

  @override
  void initState() {
    super.initState();
    widget.setRatingListener(ratingChanged);
  }

  void ratingChanged() async {
    try {
      print("Rating changed");
      if (widget.sessionId == null) return;
      double? response = await ReqController.getAvgRating(widget.sessionId!);
      if(response == null) return;
      setState(() {
        avgScore = response;
      });
    } on Exception catch (_) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 60, bottom: 20),
              child: Text(
                "Leaderboard",
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lato",
                    fontSize: 15),
              ),
            ),
            LeaderboardEntry("Juan Garcia", 15),
            LeaderboardEntry("You", 13),
            LeaderboardEntry("Ali Raza", 11),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "${(avgScore).round()}%",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 86, 193, 245),
                      fontWeight: FontWeight.bold,
                      fontFamily: "Lato",
                      fontSize: 40),
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: avgScore / 100,
                    strokeWidth: 30,
                    color: const Color.fromARGB(255, 86, 193, 245),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(top: 40), // Add padding here
          child: Column(
            children: const [
              Tips("Tip 1: Emails x AI"),
              Tips("Tip 2: Process Optimisation"),
              Tips("Tip 3: Family scheduling")
           ],
          )
        ),
      ],
    );
  }
}

class Tips extends StatefulWidget {
  const Tips(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: Container(
          height: 50.0, // Define the height
          width: 270.0, // Define the width
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovering
                  ? Colors.blue
                  : const Color.fromARGB(255, 86, 193, 245),
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.text,
              style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                  fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}

class LeaderboardEntry extends StatelessWidget {
  const LeaderboardEntry(this.name, this.points, {Key? key}) : super(key: key);

  final String name;
  final double points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              color: Colors.black,
              width: 40,
              height: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 50),
            child: SizedBox(
              width: 100,
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Lato",
                    fontSize: 15),
              ),
            ),
          ),
          Text(
            "$points pts",
            style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontFamily: "Lato",
                fontSize: 15),
          ),
        ],
      ),
    );
  }
}

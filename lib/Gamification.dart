import 'package:flutter/material.dart';
import 'package:watchat_ui/common/Score.dart';

class Gamification extends StatefulWidget {
  const Gamification({Key? key}) : super(key: key);

  @override
  _GamificationState createState() => _GamificationState();
}

class _GamificationState extends State<Gamification> {
  //List<Score> topThree;
  double avgScore = 7.93;

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
          padding: const EdgeInsets.only(top: 80),
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  "${(avgScore * 10).round()}",
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
                    value: avgScore / 10,
                    strokeWidth: 30,
                    color: const Color.fromARGB(255, 86, 193, 245),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: const [
            Tips("Tip 1"),
            Tips("Tip 2"),
            Tips("Tip 3")
          ],
        )
      ],
    );
  }
}

class Tips extends StatelessWidget {
  const Tips(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 86, 193, 245),
            width: 5,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontFamily: "Lato",
              fontSize: 15),
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

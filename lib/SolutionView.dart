import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:watchat_ui/common/Solution.dart';
import 'package:watchat_ui/widgets/chatMessage.dart';


import 'design/fontSizes.dart';

class SolutionView extends StatefulWidget {
  const SolutionView(int? sessionId, {Key? key}) : super(key: key);

  @override
  State<SolutionView> createState() => _SolutionViewState();
}

class _SolutionViewState extends State<SolutionView> {
  List<Widget> childList = [];
  late Solution sol;

  @override
  void initState() {
    super.initState();
    sol = Solution(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.",
        "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
        "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
        "Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?");

    childList = [
      SolutionText(title: "Problem", content: sol.problem),
      SolutionText(title: "Description", content: sol.description),
      SolutionText(title: "Analysis", content: sol.analysis),
      SolutionText(title: "Risks", content: sol.risks),
      SolutionText(title: "Data", content: sol.data),
    ];
  }

  Widget build(BuildContext context) {
    double inputHeight = FontSizes.flexibleEESmall(context) * 2.7;
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(60, 60, 60, 40),
              children: childList,
            ),
          ),
        ],
      ),
    );
  }
}




class SolutionText extends StatelessWidget {
  const SolutionText({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  IconData getIcon() {
    switch (title) {
      case "Problem":
        return Icons.error_outline;
      case "Description":
        return Icons.description;
      case "Analysis":
        return Icons.analytics_outlined;
      case "Risks":
        return Icons.warning_amber_outlined;
      case "Data":
        return Icons.data_usage;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        gradient: LinearGradient(
              begin: Alignment(-1, -1),
              end: Alignment(-0.9, 1.5),
              colors: [
                Colors.grey.withOpacity(0.8),
                Color.fromRGBO(86, 193, 245, 0.8),
              ],
            ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                getIcon(),
                size: 24,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            content,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Lato",
              decoration: TextDecoration.none,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

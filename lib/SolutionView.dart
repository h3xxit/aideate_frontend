import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:watchat_ui/common/Solution.dart';
import 'package:watchat_ui/controller/reqController.dart';
import 'package:watchat_ui/widgets/chatMessage.dart';

import 'design/fontSizes.dart';

class SolutionView extends StatefulWidget {
  const SolutionView(this.sessionId, {super.key});
  final int? sessionId;

  @override
  State<SolutionView> createState() => _SolutionViewState();
}

class _SolutionViewState extends State<SolutionView> {
  List<Widget> childList = [];

  var button_text =
      "Reload/ Generate Solution from the information gathered so far";

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    double inputHeight = FontSizes.flexibleEESmall(context) * 2.7;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    button_text =
                        'Generating the solution, please have some patience! It might take up to two minutes!';
                  });

                  Solution? sol;

                  /*sol = Solution(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.",
                      "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
                      "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
                      "Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?");*/

                  if (widget.sessionId == null) {
                    return;
                  }
                  sol = await ReqController.getSolution(widget.sessionId!);
                  List<Widget> tmp = [];
                  if(sol!.risks == "Error"){
                    if(widget.sessionId == 1){
                      tmp = [
                      SolutionText(title: "Required Data", content: "Data sources required by this use case would include historical energy usage patterns and real-time energy consumption data to accurately forecast the energy demand of the consumers. Additionally, data on weather patterns and other environmental factors could be incorporated to optimize solar panel energy production results and pricing models."),
                      SolutionText(title: "Involved Risks", content: "Risks involved include high integration costs and extensive development effort, the computational and maintenance challenges of an integrated Al system, and the need for comprehensive user data, which could face data privacy challenges."),
                      SolutionText(
                          title: "Detailed Analysis", content: "By using Al to optimize the solar energy matching process, the solar-powered houses can rent their energy to more consumers, leading to greater overall revenue. The demand forecasting by Al will ensure an efficient flow of energy, minimize energy wastage, and maximize the solar panels' energy production. Additionally, Al pricing models could optimize charging rates, increase consumer satisfaction, and lead to increased revenue."),
                      SolutionText(
                          title: "Description how AI can help",
                          content: "Al can be applied to optimize the matching process between solar-powered houses and consumers based on energy demand forecasts, real-time energy monitoring, and pricing algorithms. Al can predict energy demand patterns to match solar energy supply with demand in real-time which will ensure that the solar panel owner always have a buyer for their energy, and the consumer gets the best prices. Al will also monitor and control the energy production to minimize energy wastage maximizes the energy production efficiency of the solar panels."),
                      SolutionText(
                          title: "Identified Problem", content: "Solar-powered houses want to rent out their energy to consumers in their area, but need to ensure optimal matching and usage to maximize revenue."),
                    ];
                    }else{
                        tmp = [SolutionText(title: "Not enough data!", content: "Not enough data to generate solutions. Please talk to the consultant more")];
                    }
                  } else {
                    tmp = [
                      SolutionText(title: "Required Data", content: sol!.data),
                      SolutionText(title: "Involved Risks", content: sol.risks),
                      SolutionText(
                          title: "Detailed Analysis", content: sol.analysis),
                      SolutionText(
                          title: "Description how AI can help",
                          content: sol.description),
                      SolutionText(
                          title: "Identified Problem", content: sol.problem),
                    ];
                  }

                  if (this.mounted) {
                    setState(() {
                      childList = tmp;
                      button_text =
                          "Reload/ Generate Solution from the information gathered so far";
                    });
                  };
                  // Add your onPressed function here
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh, color: Colors.white), // Add reload icon
                    SizedBox(
                        width: 8), // Add some spacing between icon and text
                    Text(
                      button_text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10), // Adjust padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5, // Add a shadow to the button
                  shadowColor: Colors.black, // Set shadow color
                ),
              ),
            ),
          ),
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
      case "Identified Problem":
        return Icons.error_outline;
      case "Description how AI can help":
        return Icons.description;
      case "Detailed Analysis":
        return Icons.analytics_outlined;
      case "Involved Risks":
        return Icons.warning_amber_outlined;
      case "Required Data":
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

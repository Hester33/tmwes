import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:tmwes/constants/image.dart';
import 'package:tmwes/constants/text.dart';
import 'dart:math' as math;

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text(
          'FAQ',
        ),
      ),
      body: ExpandableTheme(
        data: ExpandableThemeData(
          iconColor: Colors.blueGrey.shade400,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            SizedBox(height: 20),
            CardFaq(
              cardTitle: "What is TMWES?",
              cardSubs: whatIsTMWESDesc,
              cardNo: 1,
            ),
            CardFaq(
              cardTitle: "How does TMWES help with managing migraines?",
              cardSubs: howTMWESHelpDesc,
            ),
            CardFaq(
              cardTitle: "What is Headache Impact Test (HIT-6)?",
              cardSubs: whtIsHIT6Desc,
              cardNo: 3,
            ),
            CardFaq(
              cardTitle: "How many Headache Impact Test (HIT-6) should I take?",
              cardSubs: howManyHIT6Desc,
            ),
            CardFaq(
              cardTitle: "Is my personal data secure with TMWES?",
              cardSubs: personalDataDesc,
            ),
            CardFaq(
              cardTitle: "Can TMWES replace professional medical advice?",
              cardSubs: replaceProfessionalAdviceDesc,
            ),
            CardFaq(
              cardTitle: "Can TMWES help me prepare for my daily routine?",
              cardSubs: prepareDailyRoutineDesc,
            ),
          ],
        ),
      ),
    );
  }
}

class CardFaq extends StatelessWidget {
  final String cardTitle;
  final String cardSubs;
  final int? cardNo;
  const CardFaq(
      {super.key,
      required this.cardTitle,
      required this.cardSubs,
      this.cardNo = 0});

  @override
  Widget build(BuildContext context) {
    buildItem(String label) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(label),
      );
    }

    buildList() {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(children: <Widget>[
          Text(cardSubs, textAlign: TextAlign.justify),
          const SizedBox(
            height: 10,
          ),
          returnImage(cardNo!)
        ]),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(children: <Widget>[
            ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToExpand: true,
                tapBodyToCollapse: true,
                hasIcon: false,
              ),
              header: Container(
                color: Colors.blueGrey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: [
                    ExpandableIcon(
                      theme: const ExpandableThemeData(
                        expandIcon: Icons.arrow_right,
                        collapseIcon: Icons.arrow_drop_down,
                        iconColor: Colors.white,
                        iconSize: 28.0,
                        iconRotationAngle: math.pi / 2,
                        iconPadding: EdgeInsets.only(right: 5),
                        hasIcon: false,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        cardTitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ]),
                ),
              ),
              collapsed: Container(),
              expanded: buildList(),
            ),
          ]),
        ),
      ),
    ));
  }
}

returnImage(int value) {
  switch (value) {
    case 1:
      return Image.asset(
        logo,
        width: 100,
        height: 100,
      );

    case 3:
      return Image.asset(
        HIT6ScoreRangeImg,
        //width: 12,
        height: 120,
      );
    default:
      return const Text("");
  }
}

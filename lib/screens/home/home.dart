import 'package:flutter/material.dart';

import 'package:htask/models/service_model.dart';
import 'package:htask/models/tab_bar_model.dart';
import 'package:htask/screens/home/widgets/service_item.dart';
import 'package:htask/styles/colors.dart';
import 'package:htask/styles/text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    const double padding = 14;
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _HomeHeader(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(padding),
                child: SizedBox(
                    height: height * 0.13, child: const _HomeServiceToday()),
              ),
              const Padding(
                padding: EdgeInsets.all(padding),
                child: _HomeTabsStatuses(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AppColors.blue1,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/pseronal_image.png'),
            radius: 40,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Hello, Ahmed',
                style: AppTextStyles.textStyle1,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Have a greate working day',
                style: AppTextStyles.textStyle2,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _HomeServiceToday extends StatelessWidget {
  const _HomeServiceToday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your service today are: '),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  ),
              scrollDirection: Axis.horizontal,
              itemCount: servicesToday.length,
              itemBuilder: (_, index) {
                return ServiceItem(serviceModel: servicesToday[index]);
              }),
        )
      ],
    );
  }
}

class _HomeTabsStatuses extends StatefulWidget {
  const _HomeTabsStatuses({Key? key}) : super(key: key);

  @override
  State<_HomeTabsStatuses> createState() => _HomeTabsStatusesState();
}

class _HomeTabsStatusesState extends State<_HomeTabsStatuses> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBars.length,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.selectedColor.withOpacity(0.38),
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(8),
            child: TabBar(
              isScrollable: true,
              padding: const EdgeInsets.all(0),
              tabs: tabBars.map((tap) => _buildTapContent(tap)).toList(),
              indicator:
                  const UnderlineTabIndicator(borderSide: BorderSide.none),
              onTap: onTapPressed,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
              height: 1000,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(8),
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: tabBars.map((e) => e.widget).toList())))
        ],
      ),
    );
  }

  Widget _buildTapContent(TabBarItem tab) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: tab.isSelected ? AppColors.white : null,
          borderRadius: tab.isSelected ? BorderRadius.circular(30) : null),
      child: Row(
        children: [
          if (tab.isSelected)
            Row(
              children: [
                Image.asset(tab.imagePath, scale: 1.3),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          Text(
            tab.text,
            style: const TextStyle(
                fontSize: 18, color: AppColors.darkPrimaryColor),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  void onTapPressed(index) {
    setState(() {
      for (int i = 0; i < tabBars.length; i++) {
        tabBars[i].isSelected = false;
      }
      tabBars[index].isSelected = true;
    });
  }
}

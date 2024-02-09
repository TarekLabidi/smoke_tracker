import 'dummydata.dart';
import 'pages/brands_page.dart';
import 'pages/history_page.dart';
import 'pages/today_page.dart';
import 'palette.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> pages = [];
  var pageController = PageController();

  void initializePages() {
    pages = [
      TodayPage(
        currentIndexCallBack: (currentIndex) {
          setState(() {
            this.currentIndex = currentIndex;
            pageController.animateToPage(currentIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
          });
        },
      ),
      const BrandsPage(),
      const HistoryPage()
    ];
  }

  void informations() {}

  @override
  void initState() {
    super.initState();
    initializePages();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            elevation: 3,
            backgroundColor: Palette.tink,
            title: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      'Keep Track of Health',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      "assets/images/loko.png",
                      height: 60,
                      width: 60,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              9),
                                  child: Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Palette.tink,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 20),
                                            Text(
                                              'App Infos',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(color: Colors.blue),
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              desc,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Row(
                                              children: [
                                                Text(
                                                  'RS ,Tarek Laabidi',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w100,
                                                  ),
                                                ),
                                                Spacer(),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.help,
                          size: 30,
                          color: Colors.blue,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
        body: PageView(
          children: pages,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          controller: pageController,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Today',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ballot_rounded),
              label: 'Brands',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              pageController.animateToPage(currentIndex,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear);
            });
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedNav = 0;

  List<Widget> body = [
    Dashboard(),
    Discussion(),
    Videos(),
    Tasks(),
  ];

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.of(context).size.width;
    bool useSidebar = widht >= 600;

    return Scaffold(
      key: _scaffoldKey,
      drawer: SidebarNav(
        currentIndex: selectedNav,
        items: [
          SidebarItem(
            iconData: CupertinoIcons.home,
            label: "Dashboard",
          ),
          SidebarItem(
            iconData: CupertinoIcons.chat_bubble,
            label: "Discussion",
          ),
          SidebarItem(
            iconData: CupertinoIcons.film,
            label: "Videos",
          ),
          SidebarItem(
            iconData: CupertinoIcons.folder,
            label: "Tasks",
          ),
        ],
        onTap: (int index) {
          setState(() {
            selectedNav = index;
          });
        },
      ),
      body: SafeArea(
        child: Row(
          children: [
            if (useSidebar)
              SidebarNav(
                currentIndex: selectedNav,
                items: [
                  SidebarItem(
                    iconData: CupertinoIcons.home,
                    label: "Dashboard",
                  ),
                  SidebarItem(
                    iconData: CupertinoIcons.chat_bubble,
                    label: "Discussion",
                  ),
                  SidebarItem(
                    iconData: CupertinoIcons.film,
                    label: "Videos",
                  ),
                  SidebarItem(
                    iconData: CupertinoIcons.folder,
                    label: "Tasks",
                  ),
                ],
                onTap: (int index) {
                  setState(() {
                    selectedNav = index;
                  });
                },
              ),
            Expanded(
              child: Container(
                color: Colors.blueGrey[50],
                child: Stack(
                  children: [
                    Center(child: body[selectedNav]),
                    if (!useSidebar)
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(Icons.menu),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("assets/images/google.png"),
        ),
        Text("Dashboard"),
      ],
    );
  }
}

class Discussion extends StatelessWidget {
  const Discussion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("assets/images/google.png"),
        ),
        Text("Discussion"),
      ],
    );
  }
}

class Videos extends StatelessWidget {
  const Videos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("assets/images/google.png"),
        ),
        Text("Videos"),
      ],
    );
  }
}

class Tasks extends StatelessWidget {
  const Tasks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("assets/images/google.png"),
        ),
        Text("Tasks"),
      ],
    );
  }
}

class SidebarNav extends StatefulWidget {
  const SidebarNav({
    Key? key,
    required this.items,
    required this.currentIndex,
    this.onTap,
  }) : super(key: key);

  final List<Widget> items;
  final int currentIndex;
  final Function(int)? onTap;

  @override
  _SidebarNavState createState() => _SidebarNavState();
}

class _SidebarNavState extends State<SidebarNav> {
  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.of(context).size.width;
    bool isDesktop = widht >= 900;
    bool isTablet = widht >= 600 && widht < 900;
    bool isHandset = widht < 600;
    return Container(
      width: isDesktop || isHandset ? 280 : 70,
      color: Colors.white,
      child: Scrollbar(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  if (isDesktop)
                    Padding(
                      padding: isDesktop
                          ? const EdgeInsets.all(20.0)
                          : const EdgeInsets.all(4.0),
                      child: Image(
                        image: AssetImage("assets/images/google.png"),
                        height: 140,
                      ),
                    ),
                  if (isTablet)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        "assets/images/classroom.svg",
                        width: 50,
                        height: 50,
                      ),
                    ),
                  const SizedBox(height: 20),
                  Column(
                    children: _createTiles(),
                  ),
                ],
              ),
            ),
            SidebarItem(
              iconData: CupertinoIcons.settings,
              label: "Setting",
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _createTiles() {
    print("build tiles");
    final List<Widget> tiles = <Widget>[];
    final List test = [];
    for (int i = 0; i < widget.items.length; i++) {
      tiles.add(
        SidebarTile(
          item: widget.items[i],
          onTap: () {
            widget.onTap?.call(i);
          },
          selected: i == widget.currentIndex,
        ),
      );
      test.add(i == widget.currentIndex);
    }
    print(test);
    print(widget.currentIndex);
    return tiles;
  }
}

class SidebarTile extends StatefulWidget {
  final Widget item;
  final void Function() onTap;
  final bool selected;

  const SidebarTile(
      {Key? key,
      required this.item,
      required this.onTap,
      required this.selected})
      : super(key: key);

  @override
  _SidebarTileState createState() => _SidebarTileState();
}

class _SidebarTileState extends State<SidebarTile> {
  @override
  void didUpdateWidget(covariant SidebarTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      print("berubah");
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.selected);
    return Material(
      color: widget.selected ? Colors.green.withOpacity(0.09) : Colors.white,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: widget.selected
                  ? BorderSide(
                      color: Colors.green,
                      width: 3,
                    )
                  : BorderSide.none,
            ),
          ),
          child: widget.item,
        ),
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  const SidebarItem({
    Key? key,
    required this.iconData,
    required this.label,
  }) : super(key: key);

  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    double widht = MediaQuery.of(context).size.width;
    bool isDesktop = widht >= 900;
    bool isHandset = widht < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Container(
        child: Row(
          children: [
            Icon(
              iconData,
              color: Color(0xff2CA15E),
            ),
            if (isDesktop || isHandset)
              Row(
                children: [
                  const SizedBox(width: 16),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.button!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff2CA15E),
                        ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

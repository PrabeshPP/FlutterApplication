import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_flutter/views/tabs/card_swipe_tab.dart';
import 'package:pull_flutter/views/tabs/chats_tab.dart';

class PullHomePage extends ConsumerStatefulWidget {
  const PullHomePage({Key? key, required this.title, required this.path}) : super(key: key);

  final String title;
  final String path;

  @override
  ConsumerState<PullHomePage> createState() => _PullHomePageState();
}

class _PullHomePageState extends ConsumerState<PullHomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final tabs = const <String, Widget>{'cards': CardSwipeTab(), 'chats': ChatsTab()};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.fastOutSlowIn,
        child: tabs[widget.path]!,
        transitionBuilder: (_widget, animation) {
          if (_widget == tabs[widget.path]!) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(animation),
                child: _widget,
              ),
            );
          } else {
            return FadeTransition(
              opacity: Tween<double>(begin: 1, end: 0).animate(animation),
              child: _widget,
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabs.keys.toList().indexOf(widget.path),
        items: const [
          BottomNavigationBarItem(label: 'Cards', icon: Icon(Icons.people_outline_sharp)),
          BottomNavigationBarItem(label: 'Chats', icon: Icon(Icons.chat))
        ],
        onTap: (i) {
          context.go('/home/${tabs.keys.elementAt(i)}');
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

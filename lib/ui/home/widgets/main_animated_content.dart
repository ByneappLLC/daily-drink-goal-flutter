import 'package:daily_beer_goal_fl/ui/widgets/tiltable_container.dart';
import 'package:flutter/material.dart';

import '../home_animator.dart';
import 'main_content.dart';

class MainAnimatedContent extends StatelessWidget {
  final HomeScreenAnimator animator;

  const MainAnimatedContent({
    Key key,
    this.animator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mainContent = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 30, spreadRadius: 20, color: Colors.black12)
        ],
      ),
      child: MainContent(
        onMenuPressed: animator.openMenu,
        onSettingsPressed: () {},
      ),
    );
    return AnimatedBuilder(
      animation: animator.drawerController,
      child: _mainContent,
      builder: (context, widget) => Transform(
        alignment: Alignment.centerLeft,
        transform:
            Matrix4.translationValues(animator.translateRight.value, 0.0, 0.0)
              ..scale(animator.scaleDown.value),
        child: TiltableContainer(
          child: widget,
          disabled: !animator.drawerIsOpen,
          onTap: animator.closeMenu,
        ),
      ),
    );
  }
}

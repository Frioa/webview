import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class AdvancedScene extends StatefulWidget {
  @override
  _AdvancedSceneState createState() => _AdvancedSceneState();
}

class _AdvancedSceneState extends State<AdvancedScene> {
  int _currentIndex = 2;
  bool _extended = false;

  double _textScaleFactor = 1;
  double _fontSize = 14;
  double _timeDilation = 1;
  List<bool> _selectedDemos = [true, false];
  List<bool> _selectedLeadings = [false, true];
  List<bool> _selectedLabelTypes = [true, false, false];
  List<bool> _selectedGroupAlignments = [true, false, false];
  List<bool> _selectedHyphenatedLabel = [false, true];
  List<bool> _selectedExtendedDemos = [true, false];

  Color _backgroundColor;
  MaterialColor _primarySwatch;
  NavigationRailLabelType _labelType;
  double _groupAlignment;
  Widget _leading;
  TextStyle _labelTextStyle;
  TextStyle _selectedLabelTextStyle;
  String _thirdLabelString;
  IconThemeData _iconThemeData;
  PointerEnterEventListener _onEnter;
  PointerExitEventListener _onExit;

  @override
  Widget build(BuildContext context) {
    final toggleMenu = () {
      setState(() {
        _extended = !_extended;
      });
    };

    /// 1. 设置 timeDilation ，增加动画延迟时间
    timeDilation = _timeDilation;

    NavigationRailLabelType labelType;
    if (_selectedLabelTypes[0]) labelType = NavigationRailLabelType.values[0];
    if (_selectedLabelTypes[1]) labelType = NavigationRailLabelType.values[1];
    if (_selectedLabelTypes[2]) labelType = NavigationRailLabelType.values[2];

    double groupAlignment;
    if (_selectedGroupAlignments[0]) groupAlignment = -1.0;
    if (_selectedGroupAlignments[1]) groupAlignment = 0.0;
    if (_selectedGroupAlignments[2]) groupAlignment = 1.0;

    if (_selectedDemos[0]) {
      _extended = false;
      _backgroundColor = Colors.white;
      _primarySwatch = Colors.deepPurple;
      _leading = _selectedLeadings[0] ? null : NavigationRailFab();
      _labelType = labelType;
      _thirdLabelString = _selectedHyphenatedLabel[0] ? 'Longer\nThird' : 'Third';
      _groupAlignment = groupAlignment;
      _labelTextStyle = TextStyle(fontSize: _fontSize);
      _selectedLabelTextStyle = TextStyle(fontSize: _fontSize);
      _iconThemeData = IconThemeData();
      _onEnter = null;
      _onExit = null;
    }
    if (_selectedDemos[1]) {
      _backgroundColor = Colors.blueGrey;
      _primarySwatch = Colors.amber;
      _labelType = NavigationRailLabelType.none;
      _thirdLabelString = 'Third';
      _groupAlignment = -1;
      _labelTextStyle = TextStyle(fontSize: _fontSize, color: Colors.white);
      _selectedLabelTextStyle = TextStyle(fontSize: _fontSize, color: Colors.amber);
      _iconThemeData = IconThemeData(color: Colors.white.withOpacity(0.7));

      if (_selectedExtendedDemos[0]) {
        _leading = NavigationRailFab();
        _onEnter = (PointerEnterEvent event) {
          print('object');
          setState(() {
            _extended = true;
          });
        };

        _onExit = (PointerExitEvent event) {
          setState(() {
            _extended = false;
          });
        };
      }
      if (_selectedExtendedDemos[1]) {
        _leading = NavigationRailMenu(toggleMenu: toggleMenu);
        _onEnter = null;
        _onExit = null;
      }
    }

    //  2. NavigationRail 非常适合在移动和桌面设备之间切换的应用，
    //  当您的应用所在的屏幕尺寸增大时，您可以非常容易地从 BottomNavigator 切换成 NavigationRail。
    final rail = NavigationRail(
      minWidth: 72,
      labelType: _labelType,
      groupAlignment: _groupAlignment,
      backgroundColor: _backgroundColor,
      extended: _extended,
      leading: _leading,
      destinations: [
        NavigationRailDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: Text('First'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: Text('Second'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: Text(
            _thirdLabelString,
            textAlign: TextAlign.center,
          ),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: Text('Fourth'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: Text('Fifth'),
        )
      ],
      selectedIndex: _currentIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      unselectedLabelTextStyle: _labelTextStyle,
      selectedLabelTextStyle: _selectedLabelTextStyle,
      unselectedIconTheme: _iconThemeData,
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text('NavigationRail')),
        backgroundColor: Colors.white,
        body: Row(
          textDirection: TextDirection.ltr,
          children: <Widget>[
            MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: _textScaleFactor),
              child: Theme(
                data: ThemeData(
                  primarySwatch: _primarySwatch,
                ),
                child: GestureDetector(
                  child: rail,
                  onDoubleTap: () {
                    print('onLongPress');
                    if (_onEnter != null) {
                      _extended = !_extended;
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
            VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                alignment: Alignment.topCenter,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text('Text Scale Factor'),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: Slider(
                        min: 0.5,
                        max: 4,
                        divisions: 14,
                        label: _textScaleFactor.toStringAsFixed(2),
                        value: _textScaleFactor,
                        onChanged: (double value) {
                          setState(() {
                            _textScaleFactor = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Label Font Size'),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: Slider(
                        min: 6,
                        max: 72,
                        divisions: 33,
                        label: _fontSize.toStringAsFixed(0),
                        value: _fontSize,
                        onChanged: (double value) {
                          setState(() {
                            _fontSize = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Time Dilation'),
                    SizedBox(height: 20),
                    SliderTheme(
                      data: SliderThemeData(
                        showValueIndicator: ShowValueIndicator.always,
                      ),
                      child: SizedBox(
                        width: 400,
                        child: Slider(
                          min: 1,
                          max: 20,
                          label: _timeDilation.toStringAsFixed(0),
                          value: _timeDilation,
                          onChanged: (double value) {
                            setState(() {
                              _timeDilation = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Navigation Rail Demo Type'),
                    SizedBox(height: 20),
                    _ToggleButtons(
                      labels: ['Normal', 'Extended'],
                      selected: _selectedDemos,
                      setState: setState,
                    ),
                    if (_selectedDemos[0]) ...[
                      SizedBox(height: 40),
                      Text('Leading'),
                      SizedBox(height: 20),
                      _ToggleButtons(
                        labels: ['None', 'FAB'],
                        selected: _selectedLeadings,
                        setState: setState,
                      ),
                      SizedBox(height: 20),
                      Text('Label Type'),
                      SizedBox(height: 20),
                      _ToggleButtons(
                        labels: ['None', 'Selected', 'All'],
                        selected: _selectedLabelTypes,
                        setState: setState,
                      ),
                      SizedBox(height: 20),
                      Text('Group Alignment'),
                      SizedBox(height: 20),
                      _ToggleButtons(
                        labels: ['Top', 'Center', 'Bottom'],
                        selected: _selectedGroupAlignments,
                        setState: setState,
                      ),
                      SizedBox(height: 20),
                      Text('2-Line Label'),
                      SizedBox(height: 20),
                      _ToggleButtons(
                        labels: ['Yes', 'No'],
                        selected: _selectedHyphenatedLabel,
                        setState: setState,
                      ),
                    ],
                    if (_selectedDemos[1]) ...[
                      SizedBox(height: 40),
                      Text('Leading'),
                      SizedBox(height: 20),
                      _ToggleButtons(
                        labels: ['FAB', 'Menu'],
                        selected: _selectedExtendedDemos,
                        setState: setState,
                      ),
                    ]
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

class NavigationRailFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// 3. 使用 InheritedWidget 共享动画状态
    final animation = NavigationRail.extendedAnimation(context);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        if (animation.value > 0) {
          return Container(
            height: 56,
            padding: EdgeInsetsDirectional.only(
              top: (12 * animation.value).clamp(0, 12).toDouble(),
              bottom: (12 * animation.value).clamp(0, 12).toDouble(),
              start: 8,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              heightFactor: 1.0,
              widthFactor: animation.value,
              child: FloatingActionButton.extended(
                elevation: 1,
                icon: Icon(Icons.access_alarm),
                label: Text('CREATE', style: TextStyle(fontSize: 12 * animation.value)),
                onPressed: () {},
                clipBehavior: Clip.antiAlias,
              ),
            ),
          );
        } else {
          return FloatingActionButton(
            elevation: 1,
            child: Icon(Icons.add),
            onPressed: () {},
          );
        }
      },
    );
  }
}

/// header
class NavigationRailMenu extends StatelessWidget {
  NavigationRailMenu({this.toggleMenu});

  final VoidCallback toggleMenu;

  @override
  Widget build(BuildContext context) {
    final animation = NavigationRail.extendedAnimation(context);
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(16),
        child: AnimatedIcon(
          color: Colors.white,
          icon: AnimatedIcons.home_menu,
          progress: animation,
        ),
      ),
      onTap: toggleMenu,
    );
  }
}

class _ToggleButtons extends StatelessWidget {
  _ToggleButtons({
    this.labels,
    this.setState,
    this.selected,
  });

  final List<String> labels;
  final StateSetter setState;
  final List<bool> selected;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: [
        for (final label in labels)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w300),
            ),
          ),
      ],
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < selected.length; i++) {
            if (i == index) {
              selected[i] = true;
            } else {
              selected[i] = false;
            }
          }
        });
      },
      isSelected: selected,
    );
  }
}

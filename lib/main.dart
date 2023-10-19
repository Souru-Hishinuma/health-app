import 'package:flutter/material.dart';

void main() => runApp(MyApp());// MyAppを起動

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedDate = DateTime.now(); //現在時刻を取得
  int _selectedIndex = 0; // 選択されたインデックスをトラッキングする

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, //Appbarの背景色を無しに
        elevation: 0, //Appbarの影をなしに設定
        centerTitle: true, //titleの位置を中央に
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left, color: Colors.black),
              onPressed: () => _changeDate(-1),
            ),
            Text(
              _formatDate(_selectedDate),
              style: TextStyle(color: Colors.black),//test
            ),
            IconButton(
              icon: Icon(Icons.chevron_right, color: Colors.black),
              onPressed: () => _changeDate(1),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(child: Text("ここに各コンテンツがくる")),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            _buildBottomNavItem(0, Icons.home),
            _buildBottomNavItem(1, Icons.calendar_today),
            _buildBottomNavItem(2, Icons.signal_cellular_alt),
            _buildBottomNavItem(3, Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(int index, IconData icon) { //フッターアイテム
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          color: _selectedIndex == index ? Colors.green : null, //選択したフッターアイテムの背景色を緑に
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(icon,
                color: _selectedIndex == index ? Colors.white : Colors.black), //選択したフッターアイテムのアイコンを白、他を黒に
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) { //FMT変更用の関数
    String month = _getMonthName(date.month); //_getMonthName関数呼び出し
    String day = date.day.toString();
    return "$month $day${_getDaySuffix(int.parse(day))}";
  }

  String _getMonthName(int month) { //月を英語に変換
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  String _getDaySuffix(int day) { //日付を指定のFMTにはまるように変換
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  void _changeDate(int daysToAdd) { //日付を操作
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: daysToAdd));
    });
  }
}

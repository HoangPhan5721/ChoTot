import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4CAF50), // Màu nền của AppBar
        title: Text(
          'Thông báo',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight), // Đảm bảo TabBar có chiều cao cố định
          child: Container(
            color: Colors.white, // Màu nền của TabBar
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Hoạt động'),
                Tab(text: 'Tin mới'),
              ],
              // indicator: BoxDecoration(
                // color: Colors.transparent, // Ẩn chỉ báo dưới tab
              // ),
              indicatorColor: Colors.green, // Màu chỉ báo dưới tab
              // indicatorWeight: 4.0,
              labelColor: Colors.black,    // Màu text khi tab được chọn
              unselectedLabelColor: Colors.grey, // Màu text khi tab không được chọn
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Text('Không có hoạt động nào mới', style: TextStyle(fontSize: 18)),
          ),
          Center(
            child: Text('Chưa thể cập nhật tin mới ', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

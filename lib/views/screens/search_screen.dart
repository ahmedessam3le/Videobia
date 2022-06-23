import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:videobia/controllers/search_controller.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController _searchController = Get.put(SearchController());

  @override
  void dispose() {
    super.dispose();
    print('Search Screen Disposed');
    _searchController.dispose();
    _searchController.searchUsers.clear();
    Get.delete<SearchController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: TextFormField(
          cursorColor: Colors.white,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            filled: false,
            hintText: 'Search',
            hintStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) {
            setState(() {
              _searchController.searchForUser(value);
            });
          },
        ),
      ),
      body: _searchController.searchUsers.isEmpty
          ? Center(
              child: Text(
                'Search For Friends',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          : Obx(
              () {
                return Padding(
                  padding: EdgeInsets.all(20.r),
                  child: ListView.builder(
                    itemCount: _searchController.searchUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            _searchController.searchUsers[index].profilePicture,
                          ),
                        ),
                        title: Text(
                          _searchController.searchUsers[index].name,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

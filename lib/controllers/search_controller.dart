import 'package:get/get.dart';
import 'package:videobia/constants.dart';
import 'package:videobia/models/user.dart';

class SearchController extends GetxController {
  final Rx<List<UserModel>> _searchUsers = Rx<List<UserModel>>([]);

  List<UserModel> get searchUsers => _searchUsers.value;

  // @override
  // @mustCallSuper
  // void onInit() {
  //   super.onInit();
  //
  //   _searchUsers.bindStream(
  //     firebaseFirestore.collection('users').snapshots().map(
  //       (query) {
  //         List<UserModel> users = [];
  //         for (var element in query.docs) {
  //           users.add(UserModel.fromSnap(element));
  //         }
  //         return users;
  //       },
  //     ),
  //   );
  // }

  searchForUser(String searchText) async {
    _searchUsers.bindStream(
      firebaseFirestore.collection('users').snapshots().map(
        (query) {
          List<UserModel> allUsers = [];
          for (var element in query.docs) {
            if (element.data()['name'].toString().contains(searchText)) {
              allUsers.add(UserModel.fromSnap(element));
            }
          }
          return allUsers;
        },
      ),
    );
  }
}

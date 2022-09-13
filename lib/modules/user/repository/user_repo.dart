import 'package:movie_db/constant/app_constant.dart';
import 'package:movie_db/data/remote/network_service.dart';
import 'package:movie_db/modules/user/add/model/add_user_response.dart';
import 'package:movie_db/modules/user/detail/model/detail_user_response.dart';
import 'package:movie_db/modules/user/list/model/get_user_model.dart';


class UserRepository extends NetworkService {

  UserRepository();
  UserRepository._privateConstructor();
  static final UserRepository _instance = UserRepository._privateConstructor();
  static UserRepository get instance => _instance;

  Future<GetUserResponse> getUser() async {
    var map =
        await getMethod(URL_BASE);
    print(map);
    return GetUserResponse.fromJson(map);
  }

  Future<AddUserResponse> postUser(String name, String age) async {
    var bodyRequest = {
      'name' : name,
      'umur' : age,
    };
    var map = await postMethod(URL_BASE, bodyRequest);
    print(map);
    return AddUserResponse.fromJson(map);
  }

  Future<DetailUserResponse> getDetailUser(int userId) async {
    var map = await getMethod("${URL_BASE}$userId");
    print(map);
    return DetailUserResponse.fromJson(map);
  }

  Future<DetailUserResponse> updateUserData(String name, String age, int userId) async {
    var bodyRequest = {
      'name' : name,
      'umur' : age,
    };
    var map = await updateMethod("$URL_BASE$userId", bodyRequest);
    print(map);
    return DetailUserResponse.fromJson(map);
  }

  Future<DetailUserResponse> deleteData(int userId) async {
    var map = await deleteMethod("$URL_BASE$userId");
    print(map);
    return DetailUserResponse.fromJson(map);
  }

}

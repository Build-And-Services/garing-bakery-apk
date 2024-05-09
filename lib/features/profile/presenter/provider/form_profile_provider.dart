import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:garing_bakery_apk/core/models/enum/event_loading.dart';
import 'package:garing_bakery_apk/core/models/user_model.dart';
import 'package:garing_bakery_apk/features/auth/data/service/token_service.dart';
import 'package:garing_bakery_apk/features/profile/data/model/response.dart';
import 'package:garing_bakery_apk/features/profile/data/service/profile_service.dart';
import 'package:image_picker/image_picker.dart';

class FormProfileProvider with ChangeNotifier {
  final ImagePicker imagepic = ImagePicker();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  XFile? _image;
  EventLoading _eventLoadingStatus = EventLoading.started;
  UserModel? _userProfile;
  String? _token;

  TextEditingController get name => _name;
  TextEditingController get email => _email;
  XFile? get image => _image;
  EventLoading get eventLoadingStatus => _eventLoadingStatus;
  UserModel? get userProfile => _userProfile;
  String? get token => _token;

  set setLoading(EventLoading loading) {
    _eventLoadingStatus = loading;
    notifyListeners();
  }

  void clearController() {
    _name.clear();
    _email.clear();
    _eventLoadingStatus = EventLoading.loading;
    _image = null;
  }

  Future setImage(String url) async {
    final file = await DefaultCacheManager().getSingleFile(url);

    XFile result = XFile(file.path);
    _image = result;
    notifyListeners();
  }

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await imagepic.pickImage(source: media);
    _image = img;
    notifyListeners();
  }

  imageNull() {
    _image = null;
    notifyListeners();
  }

  Map<String, String> get body => {
        "name": _name.text,
        "email": _email.text,
      };

  String? required(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  Future<UserModel?> getDataProfile() async {
    final data = await TokenService.getCacheUser();
    _userProfile = data;
    _name.text = data.name;
    _email.text = data.email;
    _eventLoadingStatus = EventLoading.done;
    notifyListeners();
    return data;
  }

  Future<void> getToken() async {
    final token = await TokenService.getToken();
    _token = token;
    notifyListeners();
  }

  Future<ProfileUpdateResponse> profileUpdate(String id) async {
    try {
      final result = await ProfileService.update(
        body,
        image!.path,
        id,
      );
      await TokenService.saveData("${result.accessToken}", result.data!);
      _userProfile = result.data;
      _token = result.accessToken;
      notifyListeners();
      return result;
    } catch (e) {
      return ProfileUpdateResponse(
        success: false,
        message: "Update Profile Failed",
        accessToken: "null",
        tokenType: "null",
      );
    }
  }
}

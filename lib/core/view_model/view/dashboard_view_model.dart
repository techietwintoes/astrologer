import 'package:astrologer/core/data_model/login_response.dart';
import 'package:astrologer/core/data_model/message_model.dart';
import 'package:astrologer/core/service/home_service.dart';
import 'package:astrologer/core/service/user_service.dart';
import 'package:astrologer/core/utils/shared_pref_helper.dart';
import 'package:astrologer/core/view_model/base_view_model.dart';
import 'package:flutter/cupertino.dart';

class DashboardViewModel extends BaseViewModel {
  HomeService _homeService;
  UserService _userService;
  SharedPrefHelper _sharedPrefHelper;
  int userId;
  MessageModel _message;
  String _messageBox;
  bool _showSendBtn = false;

  bool get showSendBtn => _showSendBtn;

  set showSendBtn(bool value) {
    _showSendBtn = value;
    notifyListeners();
  }

  String get messageBox => _messageBox;

  Stream<MessageAndUpdate> get nMsgStream => _homeService.nStream;

  void addMsgToSink(message, update) =>
      _homeService.addMsgToSink(message, update);

  LoginResponse get loginResponse => _userService.loginResponse;

  List<MessageModel> get messages => _homeService.messages?.reversed?.toList();

  DashboardViewModel(
      {@required HomeService homeService,
      @required UserService userService,
      @required SharedPrefHelper sharedPrefHelper})
      : this._homeService = homeService,
        this._userService = userService,
        this._sharedPrefHelper = sharedPrefHelper;

  init() async {
    setBusy(true);
    nMsgStream.listen((MessageAndUpdate data) {
      _messageBox = data.message;
      if (data.update) notifyListeners();
    });
    userId = await _sharedPrefHelper.getInteger(KEY_USER_ID);
    if (loginResponse?.welcomeMessage != null) {
      _sharedPrefHelper.setInt(KEY_FREE_QUES_COUNT, 1);
    }
    await _homeService.init(
        welcomeMessage: loginResponse?.welcomeMessage, userId: userId);
    setBusy(false);
  }

  Future<void> addMessage(MessageModel message) async {
    setBusy(true);
    int _freeCount = _sharedPrefHelper.getInteger(KEY_FREE_QUES_COUNT);
    await _homeService.addMessage(message, userId);
    if (_freeCount > 0) {
      await _homeService.askQuestion(_message, userId, true);
      _sharedPrefHelper.setInt(KEY_FREE_QUES_COUNT, --_freeCount);
    }
    await _homeService.askQuestion(_message, userId, false);
    setBusy(false);
  }

  @override
  void dispose() {
    super.dispose();
    _homeService.dispose();
  }
}

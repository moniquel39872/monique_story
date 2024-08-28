import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';
import 'package:kombat_flutter/http/response_model.dart';
import 'package:kombat_flutter/model/add_gold_model.dart';
import 'package:kombat_flutter/model/daily_task_model.dart';
import 'package:kombat_flutter/model/signin_history_model.dart';
import 'package:kombat_flutter/utils/app_date_util.dart';
import 'package:kombat_flutter/widget/app_toast.dart';

class MineViewController extends GetxController {
  AppService appService = Get.find<AppService>();
  Map<String, String> morseLetters = {
    "A": "01", 
    "B": "1000", 
    "C": "1010", 
    "D": "100", 
    "E": "0", 
    "F": "0010", 
    "G": "110", 
    "H": "0000", 
    "I": "00",
    "J": "0111",
    "K": "101",
    "L": "0100",
    "M": "11",
    "N": "10",
    "O": "111",
    "P": "0110",
    "Q": "1101",
    "R": "010",
    "S": "000",
    "T": "1",
    "U": "001",
    "V": "0001",
    "W": "011",
    "X": "1001",
    "Y": "1011",
    "Z": "1100"
  };

  RxBool isCipher = false.obs;
  String curMorseCode=""; String curLetters="";
  RxList<DailyTaskModel> dailyTasks = RxList();
  RxList<SigninHistoryModel> signinHistory = RxList();

  void clearCode() {
    curMorseCode = "";
    curLetters = "";
  }

  String? checkMorseCode(String code) {    
    String? letter = "";
    String mCodes = morseLetters[appService.morseCode[curLetters.length].toUpperCase()]??"0";
    if(code==mCodes[curMorseCode.length]) {
      curMorseCode += code;
      if(curMorseCode==mCodes){
        letter = appService.morseCode[curLetters.length].toUpperCase();
        curLetters += letter;
        curMorseCode = "";
      }
    } else {
      clearCode();
      letter = null;
    }    
    return letter;
  }

  bool checkMorseLetters() {
    if(curLetters == appService.morseCode) {
      clearCode();
      return true;
    }
    return false;
  }

  Future<void> addGold() async {
    NetBaseEntity<AddGoldModel> data = await appService.httpClient.addGold(appService.increasedGolds.value);
    if(data.code==200) {
      int a = appService.mineInfoModel.value?.gold??0;
      appService.mineInfoModel.value?.gold = a + appService.increasedGolds.value; 
      appService.mineInfoModel.value?.dailyGolds = int.parse(data.data?.golds??"0");  
      appService.increasedGolds.value = 0;    
    } else {
      print(data.message);
    }
  }

  Future<void> morseVerify() async {
    NetBaseEntity<int> data = await appService.httpClient.morseVerify(appService.morseCode);
    if(data.code==200) {
      appService.morseCodeGolds.value = data.data??0;
    } else {
      print(data.message);
    }
  }

  Future<void> getDailyTasks() async {
    AppToast.showLoading();
    NetBaseListEntity<DailyTaskModel> data = await appService.httpClient.getDailyTask();
    AppToast.dismiss();
    if(data.code==200) {
      dailyTasks.value = data.data!;
      await getSigninHistory();
      for(int i=0;i<dailyTasks.length;i++) {
        dailyTasks[i].isSelected = false;
        dailyTasks[i].isCompleted = checkCompletedTask(dailyTasks[i]);
      }
    } else {
      print(data.message);
    }
  }

  Future<void> getSigninHistory() async {
    AppToast.showLoading();
    NetBaseListEntity<SigninHistoryModel> data = await appService.httpClient.getSigninHistory();
    AppToast.dismiss();
    if(data.code==200) {
      signinHistory.value = data.data!;
    } else {
      print(data.message);
    }
  }

  bool checkCompletedTask(DailyTaskModel task) {
    String curDate = AppDateUtil.curDate();
    for(int i=0;i<signinHistory.length;i++) {
      if(curDate == signinHistory[i].signinDate && (signinHistory[i].points??0)>0) {
        return true;
      }
    }
    return false;
  }

  Future<bool> completeSigninTask() async {
    AppToast.showLoading();
    NetBaseEntity<String> data = await appService.httpClient.completeSigninTask();
    AppToast.dismiss();
    if(data.code==200 && data.data=='success') {
      return true;
    } else {
      return false;
    }
  }
}
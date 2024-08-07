import 'package:get/get.dart';
import 'package:kombat_flutter/app/app_service.dart';

class ExchangeController extends GetxController {
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
    // String key = morseLetters.keys.firstWhere((k)=>morseLetters[k]==curMorseCode);
    // if(key==appService.morseCode[curLetters.length]) {
    //   letter = key;
    //   curLetters += key;
    //   curMorseCode="";
    // } else {
    // }
    return letter;
  }
}
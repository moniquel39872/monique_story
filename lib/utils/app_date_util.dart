import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:retrofit/retrofit.dart';

class AppDateUtil {

  /// 例如:把两时间字符串求出他们的时间差
  /// @param data1Str  '2016-10-11 18:06:03'
  /// @param data2Str  '2015-10-11 18:06:03'
  /// @return number
  static int diff(String date1Str, String date2Str) {
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime date1 = format.parse(date1Str);
    DateTime date2 = format.parse(date2Str);    
    return date1.difference(date2).inSeconds;
  }

  static String YMdhms(int timestamp) {
    if(timestamp==0) {
      return "";
    }
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    return format.format(date);
  }

  static String YMd(int timestamp) {
    if(timestamp==0) {
      return "";
    }
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    DateFormat format = DateFormat('yyyy-MM-dd');
    return format.format(date);
  }


  static String ddhhmmss(int secs) {
    int minutes = secs ~/ 60;
    secs = secs % 60;
    int hours = minutes ~/ 60;
    minutes = minutes % 60;
    int days = hours ~/ 24;
    hours = days > 0 ? hours % 24 : hours;
    return '${days > 0 ? '$days天' : ''}${pad(hours, 2, '0')}:${pad(minutes, 2, '0')}:${pad(secs, 2, '0')}';
  }

  static String dateWithCN(String dateStr) {
    if(dateStr.isNotEmpty) {
      DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
      DateTime date1 = format.parse(dateStr);
      return '${date1.year}年${pad(date1.month, 2, '0')}月${pad(date1.day, 2, '0')}日';
    }
    return dateStr;
  }

  static String curDate() {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime date = DateTime.now();
    return format.format(date);
  }

  static String pad(int n, int width, String z) {
    String nStr = n.toString();
    return nStr.length >= width ? nStr : z * (width - nStr.length) + nStr;
  }

  static String hhmmss(int secs) {
    int minutes = secs ~/ 60;
    secs = secs % 60;
    int hours = minutes ~/ 60;
    minutes = minutes % 60;
    return '${pad1(hours, 2, '0')}:${pad1(minutes, 2, '0')}:${pad1(secs, 2, '0')}';
  }

  static String pad1(int number, int length, String char) {
    String str = number.toString();
    while (str.length < length) {
      str = char + str;
    }
    return str;
  }

  static String MMddhhmm(String strDate) {
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime date1 = format.parse(strDate);
    return "${pad1(date1.month, 2, '0')}/${pad1(date1.day, 2, '0')} ${pad1(date1.hour, 2, '0')}:${pad1(date1.minute, 2, '0')}";
  }

  static String displayCloseTime(int timestamp) {
    if (timestamp >= 0) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      DateTime curDate = DateTime.now();      
      int t = date.difference(curDate).inSeconds;
      if(t>0) {
        int hours = t ~/ (3600);
        int minutes = (t % (3600)) ~/ (60);
        int seconds = (t % (60)) ;
        return '${hours}h ${minutes}m ${seconds}s';
      }
    } 
    return 'Closed';//'封盘中';
  }

  static int getCloseTimes(String closeTime) {
    if(closeTime=="" || closeTime=="0") {
      return 0;
    }
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime date1 = format.parse(closeTime);
    DateTime date2 = DateTime.now();
    return date1.difference(date2).inSeconds; 
  }

  static String doubleDigit(int a) {
    if(a<10){
      return '0$a';
    }
    return a.toString();
  }

  static List<String> getMonthDates() {
    List<String> result = [];
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime curDate = DateTime.now();
    DateTime date0 = curDate.add(const Duration(days: -29));
    for(int d=0;d<30;d++) {
      DateTime date = date0.add(Duration(days: d));
      result.add(format.format(date));
    }
    return result;
  }

  static List<String> getWeekDates() {
    List<String> result = [];
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime curDate = DateTime.now();
    DateTime date0 = curDate.add(const Duration(days: -6));
    for(int d=0;d<7;d++) {
      DateTime date = date0.add(Duration(days: d));
      result.add(format.format(date));
    }
    return result;
  }

  static int getDay(String strDate) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime date1 = format.parse(strDate);
    return date1.day;
  }

  static String getMonth(String strDate) {
    List<String> months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime date1 = format.parse(strDate);
    return months[date1.month-1];
  }

  static DateTime strToDateTime(String strDate) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    return format.parse(strDate);
  }

}

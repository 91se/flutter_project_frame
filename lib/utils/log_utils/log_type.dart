///常量
//log的type
enum LogType {
  V, //VERBOSE
  E, //ERROR
  A, //ASSERT
  W, //WARN
  I, //INFO
  D, //DEBUG
}

int logMaxLength = 1024;

///log的type 字符串说明
List logTypeStr = ["VERBOSE", "ERROR", "ASSERT", "WARN", "INFO", "DEBUG"];

///log的type 数字说明(匹配的Android原生,ios暂不清楚)
List<int> logTypeNum = [2, 6, 7, 5, 4, 3];

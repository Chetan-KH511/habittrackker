import 'package:isar/isar.dart';

//run command to generate file, dart run build_runner 
part 'app_setting.g.dart';

@Collection()
class Appsetting{
  Id id=Isar.autoIncrement;
  DateTime? firstTimeLaunch;
}
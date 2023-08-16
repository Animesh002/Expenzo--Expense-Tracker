import 'package:hive/hive.dart';


@HiveType(typeId: 1)
class OnboardingStatus {
  @HiveField(0)
  bool showOnboarding;

  OnboardingStatus(this.showOnboarding);
}

class OnboardingStatusAdapter extends TypeAdapter<OnboardingStatus> {
  @override
  final int typeId = 0;

  @override
  OnboardingStatus read(BinaryReader reader) {
    final showOnboarding = reader.readBool();
    return OnboardingStatus(showOnboarding);
  }

  @override
  void write(BinaryWriter writer, OnboardingStatus obj) {
    writer.writeBool(obj.showOnboarding);
  }
}
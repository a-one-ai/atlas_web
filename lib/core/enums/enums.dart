import '../app/app_export.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get topPadding => MediaQuery.of(this).viewPadding.top;

  double get bottom => MediaQuery.of(this).viewInsets.bottom;
}

enum Request { submitted, alreadyAdded, initial, loading }

enum ChatModes {
  gpt3,
  gptFineTuned,
  gptCentral,
  gpt4,
  llama,
  gemini,
}

extension ChatModesX on ChatModes {
  String get stringName {
    switch (this) {
      case ChatModes.gpt4:
        return 'GPT-4';
      case ChatModes.llama:
        return 'LLAMA';
      case ChatModes.gpt3:
        return 'GPT-3.5-turbo';
      case ChatModes.gemini:
        return 'Gemini';
      case ChatModes.gptFineTuned:
        return 'GPT-3.5-Fine-tuned';
      case ChatModes.gptCentral:
        return 'GPT-3.5-المركز المصري للدراسات الاستراتيجية';
    }
  }
}

enum CaseCategory {
  health,
  security,
  societal,
  religious,
  economic,
  environmental,
  incidents
}

extension CaseCategoryX on CaseCategory {
  String get key {
    switch (this) {
      case CaseCategory.health:
        return "health_crisis";
      case CaseCategory.security:
        return "security_crisis";
      case CaseCategory.societal:
        return "societal_crisis";
      case CaseCategory.religious:
        return "religious_crisis";
      case CaseCategory.economic:
        return "economic_crisis";
      case CaseCategory.environmental:
        return "environmental_crisis";
      case CaseCategory.incidents:
        return "incidents_crisis";
    }
  }
}

enum CaseStatus { newCase, pendingCase, finalizedCase }

extension CaseStatusX on CaseStatus {
  String get stringName {
    switch (this) {
      case CaseStatus.newCase:
        return 'New';
      case CaseStatus.pendingCase:
        return 'Pending';
      case CaseStatus.finalizedCase:
        return 'Finalized';
    }
  }
}

enum CaseRating { good, neutral, bad }

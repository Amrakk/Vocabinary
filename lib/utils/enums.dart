// ignore_for_file: constant_identifier_names

enum ScreenType { Small, Medium, Large }

enum AuthStatus {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}

enum WordLevel { Easy, Medium, Hard }

enum TopicLevel {Default, Easy, Medium, Hard }

TopicLevel intToWordLevel(int level) {
  switch (level) {
    case 1:
      return TopicLevel.Easy;
    case 2:
      return TopicLevel.Medium;
    case 3:
      return TopicLevel.Hard;
    default:
      return TopicLevel.Default;
  }
}

int wordLevelToInt(TopicLevel level) {
  switch (level) {
    case TopicLevel.Easy:
      return 1;
    case TopicLevel.Medium:
      return 2;
    case TopicLevel.Hard:
      return 3;
    default:
      return 1;
  }
}

String intLevelToString(int level) {
  switch (level) {
    case 1:
      return 'Easy';
    case 2:
      return 'Medium';
    case 3:
      return 'Hard';
    default:
      return 'Easy';
  }
}

enum WordNum { Default, MoreThan20, MoreThan50, MoreThan100 }

enum AmountOfFlashCards { Default, MoreThan20, MoreThan50, MoreThan100 }

enum Publicity { Public, Private }
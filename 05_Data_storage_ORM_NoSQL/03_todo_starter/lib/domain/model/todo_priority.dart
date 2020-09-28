enum TodoPriority {
  LOW,
  NORMAL,
  HIGH,
}

TodoPriority todoPriorityFromInt(int index) {
  switch (index) {
    case 0:
      return TodoPriority.LOW;
      break;
    case 1:
      return TodoPriority.NORMAL;
      break;
    case 2:
      return TodoPriority.HIGH;
      break;
    default:
      throw ArgumentError(
          "Invalid Todo priority encountered while parsing from int");
  }
}
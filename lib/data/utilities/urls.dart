class Urls {
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String newTask = '$_baseUrl/listTaskByStatus/New';
  static String completedTask = '$_baseUrl/listTaskByStatus/Completed';
}

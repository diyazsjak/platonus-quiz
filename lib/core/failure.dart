abstract class Failure {}

class WrongFileFormatFailure extends Failure {}

class WrongQuizFormatFailure extends Failure {}

class UnknownDatabaseFailure extends Failure {}

class QuizAlreadyExistsFailure extends Failure {}

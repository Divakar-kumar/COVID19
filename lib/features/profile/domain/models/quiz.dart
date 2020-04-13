class QuizFile {
  String schema;
  List<Quiz> quiz;
  List<String> links;

  QuizFile({this.schema, this.quiz, this.links});

  QuizFile.fromJson(Map<String, dynamic> json) {
    schema = json['$schema'];
    if (json['quiz'] != null) {
      quiz = new List<Quiz>();
      json['quiz'].forEach((v) {
        quiz.add(new Quiz.fromJson(v));
      });
    }
    if (json['links'] != null) {
      links = new List<dynamic>();
      json['links'].forEach((v) {
        links.add(v.toString());
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$schema'] = this.schema;
    if (this.quiz != null) {
      data['quiz'] = this.quiz.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.map((v) => v);
    }
    return data;
  }
}

class Quiz {
  String language;
  String title;
  String description;
  String path;
  String buttonText;
  String successMessage;
  String readMore;
  List<Questions> questions;

  Quiz(
      {this.language,
      this.title,
      this.description,
      this.path,
      this.buttonText,
      this.successMessage,
      this.readMore,
      this.questions});

  Quiz.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    title = json['title'];
    description = json['description'];
    path = json['path'];
    buttonText = json['buttonText'];
    successMessage = json['successMessage'];
    readMore = json['readMore'];
    if (json['questions'] != null) {
      questions = new List<Questions>();
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['title'] = this.title;
    data['description'] = this.description;
    data['path'] = this.path;
    data['buttonText'] = this.buttonText;
    data['successMessage'] = this.successMessage;
    data['readMore'] = this.readMore;
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String title;
  String description;
  String hint;
  List<Answers> answers;

  Questions({this.title, this.description, this.hint, this.answers});

  Questions.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    hint = json['hint'];
    if (json['answers'] != null) {
      answers = new List<Answers>();
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['hint'] = this.hint;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String option;
  String title;
  List<String> description;
  String youtubeUrl;
  bool correctAnswer;
  String imageUrl;

  Answers(
      {this.option,
      this.title,
      this.description,
      this.youtubeUrl,
      this.correctAnswer,
      this.imageUrl});

  Answers.fromJson(Map<String, dynamic> json) {
    option = json['option'];
    title = json['title'];
    description = json['description'].cast<String>();
    youtubeUrl = json['youtubeUrl'];
    correctAnswer = json['correctAnswer'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option'] = this.option;
    data['title'] = this.title;
    data['description'] = this.description;
    data['youtubeUrl'] = this.youtubeUrl;
    data['correctAnswer'] = this.correctAnswer;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
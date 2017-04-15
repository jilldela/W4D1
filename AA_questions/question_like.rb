require_relative 'questions_database'

class QuestionLike
  attr_accessor :user_id, :question_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| QuestionLike.new(datum) }
  end

  def self.find_by_id(id)
    follow = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL

    return nil if follow.empty?
    QuestionLike.new(follow[0])
  end

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      JOIN
        questions ON questions.id = question_likes.question_id
      WHERE
        questions.id = ?
    SQL

    return 0 if likers.empty?
    likers.map { |liker| User.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL
    likes[0]["COUNT(*)"]
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      JOIN
        users ON users.id = question_likes.user_id
      WHERE
        users.id = ?
    SQL

    return 0 if questions.empty?
    questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_likes ON question_likes.question_id = questions.id
      GROUP BY
        question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
    return nil if questions.empty?
    questions.map { |question| Question.new(question) }
  end


  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def create
    raise "#{self} is already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id)
      INSERT INTO
        question_likes(user_id, question_id)
      VALUES
        (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} is not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id, @id)
      UPDATE
        question_likes
      SET
        user_id = ?, question_id = ?
      WHERE
        id = ?
    SQL
  end
end

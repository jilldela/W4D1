require_relative 'questions_database'

class Reply
  attr_accessor :parent_id, :body, :user_id, :question_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    return nil if reply.empty?
    Reply.new(reply[0])
  end

  def self.find_by_user_id(user_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    return nil if reply.empty?
    Reply.new(reply[0])
  end

  def self.find_by_question_id(question_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    return nil if reply.empty?
    Reply.new(reply[0])
  end

  def initialize(options)
    @id = options['id']
    @parent_id = options['parent_id']
    @body = options['body']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def create
    raise "#{self} is already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @parent_id, @body, @user_id, @question_id)
      INSERT INTO
        replies(parent_id, body, user_id, question_id)
      VALUES
        (?, ?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} is not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @parent_id, @body, @user_id, @id, @question_id)
      UPDATE
        replies
      SET
        parent_id = ?, body = ?, user_id = ?, question_id = ?
      WHERE
        id = ?
    SQL
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    children = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    children.map { |child| Reply.new(child) }
  end
end

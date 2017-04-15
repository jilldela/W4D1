DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE if exists questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE if exists question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL
);

DROP TABLE if exists replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  body TEXT NOT NULL
);

DROP TABLE if exists question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL
);

INSERT INTO
  users (fname, lname)
VALUES
  ('U1', 'one'),
  ('U2', 'two'),
  ('U3', 'three');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Q1', 'Q1body', 1),
  ('Q2', 'Q2body', 1),
  ('Q3', 'Q3body', 1);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 2);

INSERT INTO
  replies (user_id, question_id, parent_id, body)
VALUES
  (1, 1, NULL, 'body0'),
  (2, 2, 1, 'body1'),
  (3, 3, 2, 'body2');

  INSERT INTO
    question_likes (user_id, question_id)
  VALUES
    (1, 1),
    (1, 1),
    (1, 3),
    (2, 1),
    (2, 1),
    (3, 1);

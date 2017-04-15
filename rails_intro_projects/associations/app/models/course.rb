class Course < ActiveRecord::Base
  has_many :enrollments,
    class_name: "Enrollment",
    primary_key: :id,
    foreign_key: :course_id

  has_many :enrolled_students,
    through: :enrollments,
    source: :user

  has_many :prerequisite,
    class_name: "Course",
    primary_key: :prereq_id,
    foreign_key: :id

  belongs_to :instructor,
    class_name: "User",
    primary_key: :id,
    foreign_key: :instructor_id
end


#
# create_table "courses", force: true do |t|
#   t.string   "name"
#   t.integer  "prereq_id"
#   t.integer  "instructor_id"
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end
#
# create_table "enrollments", force: true do |t|
#   t.integer  "course_id"
#   t.integer  "student_id"
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end
#
# create_table "users", force: true do |t|
#   t.string   "name"
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end

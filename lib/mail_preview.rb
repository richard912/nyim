class MailPreview < MailView

  def trainer_class_reminder
    course = Course.last.scheduled_courses.first

    Mailers::UserMailer.trainer_class_reminder({},{:user => course.teacher, :course => course }).deliver!
  end
end

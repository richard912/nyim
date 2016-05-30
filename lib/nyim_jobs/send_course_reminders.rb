class NyimJobs::SendCourseReminders < NyimJobs::Base

  self.description =  "sending course reminders"
  def perform
    if Site.site(:notify_before_course_starts)
      in_batches ScheduledCourse.tomorrow do |course|
        next if course.nil?
        course.attendants.reject(&:blank?).each do |student|
          Mailers::UserMailer.course_reminder({},{ :student => student, :course => course }).deliver! #if student.course_reminder_required?
        end
      end
    end
  end
end

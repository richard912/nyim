class Views::Signups::DiscloseCertificate < Application::Widget

  needs :pdf => nil

  def widget_content
    course = resource
    # for pdf, image should specify full local path
    if course.past?
      background_img = pdf ? [Rails.root,'public'] : []
      background_img << '/images/certificate_blank.jpg'
      img :src => File.join(*background_img), :style => 'z-index:-1;'
      div :class=>'display_certificate' do
        div :class=>'display_certificate_header_main' do
        end
        div :class=>'display_certificate_student' do
          text course.student.full_name.titlecase
          rawtext '&nbsp;'
        end
        div :class=>'display_certificate_completed' do
          text 'has successfully completed training for'
        end
        div :class=>'display_certificate_course' do
          text course.course.name
        end
        div :class=>'display_certificate_date' do
          text course.ends_at.strftime("%B %Y")
        end
        div :class=>'display_certificate_bottom' do
          text 'Trainee has demonstrated satisfactory skills after completing the training course with N.Y.I.M. Training, certified training specialists. You may call 212.658.1918 for a training reference.'
        end
      end
    else
      text 'certificate only available once you complete the class'
    end
  end
end

class NyimJobs::SendCertificates < NyimJobs::Base
  self.description =  "sending certificates"
  def perform
    if Site.site(:notify_when_certificate_available)
      Signup.certificates_to_be_mailed.reject(&:blank?).each do |signup|

        Mailers::UserMailer.certificate({},{ :student => signup.student, :signup => signup }).deliver
        signup.update_attribute :certificate_mailed_on, Time.now

      end
    end
  end
end

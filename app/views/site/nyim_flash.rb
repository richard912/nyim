# coding: utf-8
class Views::Site::NyimFlash < Erector::Widget
  def content
    div :class => 'flash_message', :id => 'flash_message' do
      if flash.any?
        flash.each do |key, msg|
          p do
            text msg
          end
        end
      end
    end
  end
end
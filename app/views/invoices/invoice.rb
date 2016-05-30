class Views::Invoices::Invoice < Application::Widgets::Index
  needs :pdf => nil

  def widget_content
    background_img = pdf ? [Rails.root,'public'] : []
    background_img << '/images/invoice_blank.jpg'
    img :src => File.join(*background_img), :style => 'z-index:-1;'
    div :class=>'display_invoice' do
      h1 :class=>'receipt_header' do
        text 'Receipt'
      end
      div :class=>'display_invoice_subheader' do
        p "Date: #{resource.completed_at.to_date}"
        p "Order # #{resource.order_id}"
      end
      h2 :class=>'receipt_header_2' do
        text 'Item'
      end
      div :class=>'item_list' do
        resource.purchases.each do |item|
          div :class=>'item' do
            div :class=>'item_first' do
              text item.name
            end
            div :class=>'item_second' do
              text "$#{item.price}"
            end
          end
        end
      end
      div :class=>'total' do
        text "Total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;".html_safe
        text "$#{resource.amount}"
      end
      div :class=>"disclaimer" do
        p '-' * 141
        p 'Rescheduling, Substitution and Cancellation Policies: <a href="https://training-nyc.com/assets/Policies">Policies</a>'.html_safe
        p 'No charge for substituting students at any time.'
        p 'No charge to reschedule or cancel before 5 business days of class.'
        p 'There is a $25 rescheduling, cancellation or retake rescheduling fee within 3-5 business days from the start of class.'
        p 'No refund or rescheduling permitted within 2 business days of start of class.'
        p 'No refund given for cancellations or no-shows within 2 business days from the start of class.'
        p 'If a retake is cancelled within 2 business days from the start of class, another retake may not be scheduled.'
        p 'To Reschedule or Cancel, please click on Reschedule or Cancel under the My Classes on the right hand side'
        p '**Note: Business days are Monday through Friday, 10am-5pm (excluding national holidays). Anything received after 5pm will be regarded
        as received at the start of the next business day.**'
        br
        p '***All of our trainers available for consulting and project work through NYIM. Please contact the Head Client Manager with any inquiries
        to avoid any breach of contract.***'
      end
    end
  end
end

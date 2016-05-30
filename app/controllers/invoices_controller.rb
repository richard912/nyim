class InvoicesController < ApplicationController

  layout :layout

  resourceful_actions :update, :list => :index

  display_options :submitter, :amount, :created_at, :ip, :order_id, :invoice_sent, :only => [:list]

  def invoice
    @invoice = Payment.first
    @user = @invoice.submitter
  end

  private

  def layout
    action_name == 'invoice' ? 'invoice' : 'nyim'
  end
end

class CustomStripeGateway < ActiveMerchant::Billing::StripeGateway
  class TlsConnection < ActiveMerchant::Connection
    def configure_ssl(http)
      super(http)
      http.ssl_version = :TLSv1
    end
  end

  def new_connection(endpoint)
    TlsConnection.new(endpoint)
  end
end

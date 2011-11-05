module ActiveMerchant #:nodoc:
    module Billing #:nodoc:
        module Integrations #:nodoc:
            module Ebs
                class Helper < ActiveMerchant::Billing::Integrations::Helper
                    mapping :account, 'account_id'
                    mapping :amount, 'amount'
                    mapping :customer, :name  => 'name',
                                       :email => 'email'
                      
                    mapping :billing_address,  :city     => 'city',
                                               :address1 => 'address',
                                               :state    => 'state',
                                               :pin      => 'postal_code',
                                               :country  => 'country',
                                               :phone    => 'phone'

                    mapping :shipping_address, :name     => 'ship_name',
                                               :city     => 'ship_city',
                                               :address1 => 'ship_address',
                                               :state    => 'ship_state',
                                               :pin      => 'ship_postal_code',
                                               :country  => 'ship_country',
                                               :phone    => 'ship_phone'

                    def redirect(mapping = {})
                        add_field 'return_url', mapping[:return_url]
                        add_field 'reference_no', mapping[:order_id]
                        add_field 'description', mapping[:order_desc]
                        add_field 'account_id', ActiveMerchant::Billing::Integrations::Ebs.account_id
                        add_field 'mode', ActiveMerchant::Billing::Integrations::Ebs.mode
                        add_field 'Checksum', get_checksum(
                                                    ActiveMerchant::Billing::Integrations::Ebs.account_id,
                                                    self.fields[self.mappings[:order_id]],
                                                    self.fields[self.mappings[:amount]],
                                                    mapping[:return_url],
                                                    ActiveMerchant::Billing::Integrations::Ebs.secret_key
                                                )
                    end
                    
                    private
                      def lookup_country_code(name_or_code, format = :alpha3)
                          country = Country.find(name_or_code)
                          country.code(format).to_s
                      rescue InvalidCountryCodeError
                          name_or_code
                      end
                end
            end
        end
    end
end


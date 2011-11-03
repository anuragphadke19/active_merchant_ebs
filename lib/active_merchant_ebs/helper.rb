module ActiveMerchant #:nodoc:
    module Billing #:nodoc:
        module Integrations #:nodoc:
            module Ebs
                class Helper < ActiveMerchant::Billing::Integrations::Helper
                    mapping :account, 'account_id'
                    mapping :amount, 'amount'
                    mapping :order_id, 'reference_no'
                    mapping :order_desc, 'description'
                    mapping :mode, 'mode'
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
                        add_field 'account_id', EBS_CONFIG['account_id']
                        add_field 'mode', EBS_CONFIG['mode']
                    end

                end
            end
        end
    end
end


require "active_merchant_ebs/version"
require 'base64'
require "RubyRc4.rb"

module ActiveMerchant #:nodoc:
    module Billing #:nodoc:
        module Integrations #:nodoc:
            module Ebs
                #autoload :Return, File.dirname(__FILE__) + '/active_merchant_ccavenue/return.rb'
                autoload :Helper, File.dirname(__FILE__) + '/active_merchant_ebs/helper.rb'
                autoload :Notification, File.dirname(__FILE__) + '/active_merchant_ebs/notification.rb'

                mattr_accessor :account_id
                mattr_accessor :mode
                mattr_accessor :service_url
                mattr_accessor :secret_key

                self.service_url = 'https://secure.ebs.in/pg/ma/sale/pay/'

                def self.setup
                    yield(self)
                end

                def self.notification(post)
                    Notification.new(post)
                end
            end
        end
    end
end


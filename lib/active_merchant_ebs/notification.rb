require 'RubyRc4.rb'
require 'base64'
module ActiveMerchant #:nodoc:
    module Billing #:nodoc:
        module Integrations #:nodoc:
            module Ebs
                class Notification < ActiveMerchant::Billing::Integrations::Notification
                  
                  #Necessary parameters in the :DR returned by ebs
                  NECESSARY = [
                               "Mode",
                               "PaymentID",
                               "DateCreated",
                               "MerchantRefNo",
                               "Amount",
                               "TransactionID",
                               "ResponseCode",
                               "ResponseMessage"
                              ]
                            
                  # processing geteway returned data
                  #
                  def parse(post)
                    super
                    
                    Rails.logger.debug post
                    params = ebsin_decode(post, self.secret_key)
                    params
                  end
                  
                  def ebsin_decode(data, key)
                    
                    Rails.logger.debug data
                    rc4 = RubyRc4.new(key)
                    params = (Hash[ rc4.encrypt(Base64.decode64(data.gsub(/ /,'+'))).split('&').map { |x| x.split("=") } ]).slice(* NECESSARY )
                    Rails.logger.debug params
                  end
                  
                  def successful?
                    "Transaction Successful" == self.status
                  end
                  
                    def valid?
                        verify_checksum(
                            self.security_key,
                            ActiveMerchant::Billing::Integrations::Ebs.account_id,
                            self.payment_id,
                            self.gross,
                            self.status,
                            ActiveMerchant::Billing::Integrations::Ebs.secret_key
                        )
                    end
                    
                    

                    def complete?
                        'Y' == self.status
                    end

                    def payment_id
                        params['PaymentID']
                    end

                    def transaction_id
                        params['TransactionID']
                    end

                    def secret_key
                        ActiveMerchant::Billing::Integrations::Ebs.secret_key
                    end

                    # the money amount we received in X.2 decimal.
                    def gross
                        params['Amount']
                    end

                    def status
                        params['ResponseMessage']
                    end
                    
                    private

                    def verify_checksum(checksum, *args)
                        require 'zlib'
                        Zlib.adler32(args.join('|'), 1).to_s.eql?(checksum)
                    end
                end
            end
        end
    end
end

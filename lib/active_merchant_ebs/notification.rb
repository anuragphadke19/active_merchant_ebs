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
                  def ebsin_decode(data)
                    rc4 = RubyRc4.new(self.security_key)
                    (Hash[ rc4.encrypt(Base64.decode64(data.gsub(/ /,'+'))).split('&').map { |x| x.split("=") } ]).slice(* NECESSARY )
                  end
                  
                  def successful?(data,response)
                    data["ResponseMessage"] == "Transaction Successful"
                  end
                  
                    def valid?
                        verify_checksum(
                            self.security_key,
                            ActiveMerchant::Billing::Integrations::Ebs.merchant_id,
                            self.payment_id,
                            self.gross,
                            self.status,
                            ActiveMerchant::Billing::Integrations::Ebs.work_key
                        )
                    end
                    
                    

                    def complete?
                        'Y' == self.status
                    end

                    def payment_id
                        params['Order_Id']
                    end

                    def transaction_id
                        params['nb_order_no']
                    end

                    def security_key
                        params['Checksum']
                    end

                    # the money amount we received in X.2 decimal.
                    def gross
                        params['Amount']
                    end

                    def status
                        params['AuthDesc']
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

require 'mail'

module ShareMail
    def ShareMail.send args
        mail = Mail.new do
            from    'systems.lab@mu.edu'
            to      args[:recipiant]
            body    args[:message]
            subject args[:subject]
        end
        
        mail.add_file = args[:file] if args[:file]
        
        begin 
            mail.deliver!
            puts "Mail Delivery Success"
        rescue
            puts "Mail Delivery Failure"
        end
    end
end

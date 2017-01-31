require 'json'

module Contact
    def Contact.add_contact id, args, update
        contacts = JSON.parse(File.read(getContactBook))    
        raise 'Contact Already Exists' if !update && !contacts[id].nil?    
        contacts[id] = args    
        File.write getContactBook, contacts.to_json
    end
    
    def Contact.lookup_contact id
        begin
            file = File.read(getContactBook)
            contacts = JSON.parse(file)
            contacts.key?(id) ? contacts[id] : id
        rescue
            id
        end
    end
    
    def Contact.list
        contacts = JSON.parse(File.read(Contact.getContactBook))
        contacts.each {|k,v| puts   "Name - #{k}:\n\t - Email: #{v['email']}\n\t - Inbox: #{v['path']}\n"}
    end
    
    def Contact.load
        JSON.parse(File.read(Contact.getContactBook))
    end
    
    def Contact.getContactBook
        ENV['HOME'] + '/Inbox/.config/contacts.json' 
    end
end

require 'json'

def add id, args, update
    contacts = JSON.parse(File.read(getContactBook))    
    raise 'Contact Already Exists' if !update && !contacts[id].nil?    
    contacts[id] = args
    
    File.write getContactBook, contacts.to_json
end

def lookup id
    begin
        file = File.read(getContactBook)
        contacts = JSON.parse(file)
        contacts.key?(id) ? contacts[id] : id
    rescue
        id
    end
end

def list
    contact = JSON.parse(File.read(getContactBook))
    contact.map do |k,v|
    end
end


def getContactBook
    ENV['HOME'] + '/Inbox/.config/contacts.json' 
end

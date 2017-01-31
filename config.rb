require 'json'

module Config    
    def Config.getConfigPath
        "#{ENV['HOME']}/Inbox/.config/config.json"
    end
    
    def Config.default_config 
        {
            :name => ENV['USER'], 
            :email => "#{ENV['USER']}@mscs.mu.edu",
            :status => 'online'
        }
    end
    
    # ARGS { :HARD, :default }
    def Config.createConfig args, options
        if args[:hard]
            system "rm #{Config.getConfigPath}"
            system "touch #{Config.getConfigPath}"
            system "echo '{}' > #{Config.getConfigPath}"
        end
        
        hash = {}
        json = JSON.parse(File.read(Config.getConfigPath))
        
        Config.default_config.keys.each {|k| hash[k] =  options[k]  ? options[k] : args[:default]  ? Config.default_config[k] : json[k.to_s] ? json[k.to_s] : "" }
        
        File.write Config.getConfigPath, hash.to_json unless args[:test]
    end
    
    def Config.set_online
        Config.set 'status', 'online'
    end
    
    def Config.set_offline
        Config.set 'status', 'offline'
    end
    
    def Config.set key, value
        json = JSON.parse(File.read(Config.getConfigPath))
        json[key] = value
        File.write Config.getConfigPath, json.to_json        
    end
end

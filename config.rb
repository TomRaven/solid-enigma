require 'json'

def getConfigPath
    "#{ENV['HOME']}/Inbox/.config/config.json"
end
    
def default_config 
    {
    :name => ENV['USER'], 
    :email => "#{ENV['USER']}@mscs.mu.edu",
    :status => 'online'
    }
end

# ARGS { :HARD, :default }
def createConfig args, options
  if args[:hard]
    system "rm #{getConfigPath}"
    system "touch #{getConfigPath}"
    system "echo '{}' > #{getConfigPath}"
  end

  hash = {}
  json = JSON.parse(File.read(getConfigPath))

  default_config.keys.each {|k| hash[k] =  options[k]  ? options[k] : args[:default]  ? default_config[k] : json[k.to_s] ? json[k.to_s] : "" }
  
  File.write getConfigPath, hash.to_json unless args[:test]
end

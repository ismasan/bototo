Bototo.register do
  
  on "what's the time" do |value|
    say "#{user[:name]}: the time is #{Time.now}"
  end
  
  on "uptime" do
    EM.system("ps -p#{Process.pid}") {|output, status|
      say output if status.exitstatus == 0
    }
  end
  
end
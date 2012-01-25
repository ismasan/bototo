Bototo.register do  

  on 'map me' do |value|      
    if value =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
      say url
    else
      location = CGI.escape(value)
      map_url = "http://maps.google.com/maps/api/staticmap?markers=#{location}&size=400x400&maptype=roadmap&sensor=false&format=png"
      link_url = "http://maps.google.com/maps?q=#{location}&hl=en&sll=37.0625,-95.677068&sspn=73.579623,100.371094&vpsrc=0&hnear=#{location}&t=m&z=11"
      say(map_url) {
        say link_url
      }
    end
  end
  
end


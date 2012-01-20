Bototo.register do
  
  on 'youtube me' do |value|
    get_json('http://gdata.youtube.com/feeds/api/videos', :query => {
      'orderBy' => 'relevance',
      'max-results' => 15,
      'alt' => 'json',
      'q' => CGI.escape(value)
    }) do |json|
      videos = json['feed']['entry']
      if videos
        video = videos[rand(videos.size)]
        link = video['link'].find{|l| l['rel'] == 'alternate' && l['type'] == 'text/html'}
        say link['href']
      else
        say "No youtube results, sorry!"
      end
    end
  end
  
end
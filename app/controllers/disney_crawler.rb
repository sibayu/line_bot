
require 'open-uri'
require 'nokogiri'

class DisneyCrawler
  def crawl(park)
    test = ""
    disney_html = Nokogiri::HTML(open("https://tokyodisneyresort.info/realtime.php?park=#{park}&order=wait","User-Agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"))
    # アトラクション名と時間を取得する
    attraction_info = disney_html.xpath("//*[@id=\"contents\"]/h2")
    attraction_info += disney_html.xpath("//div[contains(@class, 'realtime_item')]")
    # 余分な空白・文字の削除
    lists = attraction_info.to_s.gsub(/\n|\t|<br(\s+\/)?>|["&amp;"]|\<h2\>|<\/h2\>|\<div.*?\>/,"\n"=> ",", "\t" => "","<br(\s+/)?>"=>",",["&amp;"]=>"","\<h2\>"=>"","<\/h2\>"=>"","\<div.*?\>"=>"").split(",")
    # lists += attraction_info.to_s.strip
    lists.each do|list|
      if list.index("更新") then

      else if list.match(/FP|中|分|情報なし|案内/)
             test += list.strip+"\n"
           else if list.match(/\<.+\>/)

                else
                  test += "\n"+list.strip
                end
           end
      end
    end
    test
  end
end

crawler = DisneyCrawler.new
test = crawler.crawl("sea")
puts test







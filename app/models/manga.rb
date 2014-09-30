class Manga < ActiveRecord::Base
  has_one :manga_site
  belongs_to :manga_site


  def get_chapters
    page = Nokogiri::HTML(open(self.url))
    tds = page.css('#listing tr td')


    chapters = tds.each_with_index.map do |chapter, index|
      next unless index.even?


      {
        href: chapter.css('a').first['href'],
        text: chapter.text.gsub("\n", '')
      }
    end


    chapters.compact
  end


  def scrape(chapter_href)
    is_new_url_format = chapter_href.scan(/html/).empty?
    url = "#{ self.manga_site.url }#{ chapter_href }"
    page = Nokogiri::HTML(open(url))
    page_count = page.css('#pageMenu option').last.text.to_i
    pdf = Prawn::Document.new(page_size: 'A4')


    pdf.image open(page.css('#imgholder a img').first['src']),
      fit: [480, 672],
      position: :center,
      vposition: :center


    for i in 2..page_count
      pdf.start_new_page


      if is_new_url_format
        chapter_url = "#{ url }/#{ i }"
      else
        new_chapter_href = chapter_href.sub(/-\d+\//, "-#{ i }/")
        chapter_url = "#{ self.manga_site.url }#{ new_chapter_href }"
      end


      page = Nokogiri::HTML(open(chapter_url))


      pdf.image open(page.css('#imgholder a img').first['src']),
        fit: [480, 672],
        position: :center,
        vposition: :center
    end


    pdf
  end
end

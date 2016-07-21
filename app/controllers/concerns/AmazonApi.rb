module NoticeToSlack
  extend ActiveSupport::Concern


  class << self
    # apiで書籍情報を取得
    def getBooks isbn_code_set

    end

    # categoryを返す
    def getCategoryFromAmazon url
      @agent = Mechanize.new
      @agent.user_agent = 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)'

      page = @agent.get(url)
      category = []
      page.search("//div[@id='wayfinding-breadcrumbs_feature_div']/ul/li[not(@class!='a-breadcrumb-divider')]").each do |li|
        text = li.search('./span/a').text().gsub(/\s/, '')
        category << text unless  text.nil? || text.empty? || text == '本'
      end
      ap category.join("\t")
      sleep 2
    end
  end
end

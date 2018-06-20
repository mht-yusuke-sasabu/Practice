require 'nokogiri'
require 'open-uri'
require 'csv'

URL = ARGV[0]
doc = Nokogiri::HTML(open(URL))

# p doc.title
tableElement = doc.css('.tableElem')
 p tableElement.text

# CSV形式の文字列を作る
csv_txt = CSV.generate{|csv|
    # table内の各trタグごとに、
    tableElement.search(:tr).each do |tr|
      # その中のthとtdを探して、.textでテキスト部分を取り出す
      csv << tr.search("th,td").map{|tag| tag.text}
    end
  }
  
  # 最後に、utfからsjisに変換して出力 (古いExcelを使っているせいかutfだと文字化けしたため)
#   puts csv_txt.encode("Windows-31J", "UTF-8")


# # CSV形式の文字列を作る
# csv_txt = CSV.generate{|csv|
#     # table内の各trタグごとに、
#     tableElement.search(:tr).each do |tr|
#       # その中のthとtdを探して、.textでテキスト部分を取り出す
#       csv << tr.search("th,td").map{|tag| tag.text}
#     end
#   }
  
#   # 最後に、utfからsjisに変換して出力 (古いExcelを使っているせいかutfだと文字化けしたため)
# #   puts csv_txt.encode("Windows-31J", "UTF-8")

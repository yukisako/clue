require 'csv'

Bank.delete_all
BankDatum.delete_all

# Heroku の無料版MySQLは１時間に3200クエリという上限があるので、
# 500レコードを一括で入れる
banks = []
CSV.foreach('db/bankdata.csv') do |row|
  if row[1].to_i == 0
    banks << Bank.new(bank_id: "#{row[0]}", store_id: row[1], name: row[3] ,name_kana: row[2])
  end
  
  if banks.count % 500 == 0 && banks.count != 0
    Bank.import banks
    banks.clear
  end
end
if banks.count > 0
  Bank.import banks
  banks.clear
end

bank_names = Bank.all

bank_data = []
CSV.foreach('db/bankdata.csv') do |row|
  unless row[1].to_i == 0
    bank_data << BankDatum.new(bank_id: "#{row[0]}", store_id: row[1], bank_name: bank_names.find_by(bank_id: row[0]).name ,bank_name_kana: bank_names.find_by(bank_id: row[0]).name_kana, store_name: row[3], store_name_kana: row[2])
  end
    
  if bank_data.count % 500 == 0 && bank_data.count != 0
    BankDatum.import bank_data
    bank_data.clear
  end
end
if bank_data.count > 0
  BankDatum.import bank_data
  bank_data.clear
end

# bank_id: 銀行コード
# store_id: 0 が銀行名
# bank_flag: 1 が銀行名レコード
# bank_flag: 2 が支店名レコード

# row[0]: bank_id
# row[1]: store_id
# row[2]: name_kana
# row[3]: name
# row[4]: bank_flag
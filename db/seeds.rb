require 'csv'

CSV.foreach('db/bankdata.csv') do |row|
  if row[1].to_i == 0
    Bank.create(bank_id: "#{row[0]}", store_id: row[1], name: row[3] ,name_kana: row[2])
  end
end

bank_names = Bank.all

CSV.foreach('db/bankdata.csv') do |row|
  unless row[1].to_i == 0
    BankDatum.create(bank_id: "#{row[0]}", store_id: row[1], bank_name: bank_names.find_by(bank_id: row[0]).name ,bank_name_kana: bank_names.find_by(bank_id: row[0]).name_kana, store_name: row[3], store_name_kana: row[2])
  end
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
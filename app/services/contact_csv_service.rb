class ContactCsvService
  CSV_COLUMNS = %w(first_name last_name emails phones)

  def self.export_to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << CSV_COLUMNS
      Contact.all.find_each do |contact|
        values = contact.attributes.slice(*CSV_COLUMNS)
        values = values.map { |_k, v| v.is_a?(Array) ? v.join(Contact::ARRAY_DELIMITER) : v }
        csv.add_row values
      end
    end
  end

  def self.import_from_csv(file)
    CSV.foreach(file, headers: true) do |row|
      contact = Contact.find_or_create_by(first_name: row['first_name'], last_name: row['last_name'])
      contact.assign_attributes(row.to_hash)
      contact.save
    end
  end
end

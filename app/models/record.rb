class Record < ApplicationRecord
  belongs_to :domain, class_name: 'Domain', optional: false, inverse_of: :records

  validate :cname_validation

  enum record_type: %i[a txt cname ptr]

  def self.record_type_attribute_names
    record_types.map do |record_type, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.record_types.#{record_type}"), record_type]
    end
  end

  def cname_validation
    if self.record_type.eql? 'cname'
      if Record.where(domain_id: self.domain.id, host: self.host).count > 0
        errors.add(:host, " cannot save a CNAME record with same hostname as another registry")
      end
    end
  end
end

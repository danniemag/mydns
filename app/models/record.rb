class Record < ApplicationRecord
  require 'resolv'

  belongs_to :domain, class_name: 'Domain', optional: false, inverse_of: :records

  validates_presence_of :host, :content
  validate :cname_validation, :ipv4_validation

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

  def ipv4_validation
    if self.record_type.eql? 'a'
      self.content =~ Resolv::IPv4::Regex ? return : errors.add(:content, " is not a valid IPv4 address!")
    end
  end
end

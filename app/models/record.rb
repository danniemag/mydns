class Record < ApplicationRecord
  belongs_to :domain

  enum record_type: %i[a txt cname ptr]

  def self.record_type_attribute_names
    record_types.map do |record_type, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.record_types.#{record_type}"), record_type]
    end
  end
end

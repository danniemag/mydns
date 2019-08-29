class Record < ApplicationRecord
  belongs_to :domain

  enum type: %i[a txt cname ptr]

  def self.type_attribute_names
    types.map do |type, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.types.#{type}"), type]
    end
  end
end

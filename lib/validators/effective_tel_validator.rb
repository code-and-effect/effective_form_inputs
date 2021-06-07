# An ActiveRecord validator for any phone field that you would use with effective_tel
#
# validates :phone, effective_tel: true

class EffectiveTelValidator < ActiveModel::EachValidator
  PATTERN = /\A\(\d{3}\) \d{3}-\d{4}( x\d+)?\Z/

  def validate_each(record, attribute, value)
    if value.present?
      record.errors.add(attribute, 'is invalid') unless PATTERN =~ value
    end
  end
end

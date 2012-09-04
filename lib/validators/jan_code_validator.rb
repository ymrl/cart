class JanCodeValidator < ActiveModel::EachValidator
  include CommoditiesHelper
  def validate_each(record,attribute,value)

    if value.to_s.length != 13 && value.to_s.length != 8
      return record.errors[attribute] << 'the value has invalid length'
    end

    checksum = jancode_check(value)

    if checksum != value.last.to_i
      return record.errors[attribute] << 'checksum is invalid'
    end
  end
end


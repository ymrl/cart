class JanCodeValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)

    if value.to_s.length != 13 && value.to_s.length != 8
      return record.errors[attribute] << 'the value has invalid length'
    end

    splited = value.to_s.split('')
    even = 0
    odd  = 0
    splited[0,splited.length - 1].each_index do |i|
      if i % 2 == 0
        even += splited[i].to_i
      else
        odd += splited[i].to_i
      end
    end

    checksum = (even * 3 + odd) % 10

    if checksum != splited.last.to_i
      return record.errors[attribute] << 'checksum is invalid'
    end
  end
end


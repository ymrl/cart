module CommoditiesHelper
  def jancode_check code
    arr = nil
    if code.length == 13
      arr = code.split(//)[0,12].reverse
    elsif code.length == 8
      arr = code.split(//)[0,7].reverse
    else
      arr = code.split(//).reverse
    end
    even = 0
    odd  = 0
    arr.each_index do |i|
      if (i + 1) % 2 == 0
        even += arr[i].to_i
      else
        odd += arr[i].to_i
      end
    end
    return (10 - (even + odd * 3) % 10) % 10
  end

end

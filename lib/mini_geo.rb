module MiniGeo

  def geo
    if x_pos.nil? && y_pos.nil?
      result = "+0+0"
    elsif x_pos.nil? && y_pos.class == Fixnum
      result = "+0" + operation(y_pos)
    elsif x_pos.class == Fixnum && y_pos.nil?
      result = operation(x_pos) + "+0"
    else
      result = operation(x_pos) + operation(y_pos)
    end
    result
  end

end

private

def operation(number)
  if number > -1
    "+" + number.to_s
  else
    number.to_s
  end
end
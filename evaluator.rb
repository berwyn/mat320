@formula = nil

def evaluate(formula, values)
  # Remove everything that isn't a variable, ()'s, decimal points, and basic math operations
  formula.gsub!(/((?![qQ0-9\s\.\-\+\*\/\(\)]).)*/, '').upcase!
  begin
    formula.gsub!(/Q\d+/) { |match|
      (
        values[match.to_sym] &&
        values[match.to_sym].class.ancestors.include?(Numeric) ?
        values[match.to_sym].to_s :
        '0'
      )
    }
    instance_eval(formula)
  rescue Exception => e
    e.inspect
  end
end

def f(x)
  evaluate(String.new(@formula), {Q0: x}).round(5)
end
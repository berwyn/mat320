require_relative 'evaluator'
require 'pry'

def f(x)
  Evaluator.formula(String.new(@formula), {Q0: x}).round(5)
end

def regula_falsi(a, b)
  @tolerance = 12
  @x = nil
  i = 1

  while @tolerance > 0.005 do
    if @x.nil?
      @x = (a*f(b) - b*f(a)) / (f(b) - f(a))
    else
      @x = (@prev_x * f(b) - b*f(@prev_x)) / (f(b) - f(@prev_x))
    end
    @eff_x = f(@x)
    puts "X#{i} = #{@x.round(5)}"
    puts "f(X#{i}) = #{@eff_x}"
    unless @prev_x.nil?
      @tolerance = (@x - @prev_x).abs.round(5)
    end
    unless @tolerance == 12
      puts "Tolerance: #{@tolerance}"
    end
    @prev_x = @x
    i += 1
  end

  @prev_x
end

@formula = ARGV[0]
regula_falsi Float(ARGV[1]), Float(ARGV[2])
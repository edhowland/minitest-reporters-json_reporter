# make_exception.rb - class DivByZero, method make_exception

# TODO: class documentation
class DivByZero
  def do_it
    5 / 0
  end
end

def make_exception
  obj = DivByZero.new
  obj.do_it
end

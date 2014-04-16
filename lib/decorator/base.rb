class Decorator::Base
  def initialize(object)
    @object = object
  end

  def respond_to?(*args)
    super || @object.respond_to?(*args)
  end

  def method_missing(method, *args, &block)
    if @object.respond_to? method
      @object.send method, *args
    else
      super
    end
  end
end

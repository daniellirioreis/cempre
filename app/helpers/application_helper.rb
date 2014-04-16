module ApplicationHelper
  def decorate(object, *args)
    decorator = "#{object.class}Decorator".constantize
    decorator.new object, *args
  end
end

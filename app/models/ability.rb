class Ability
  include CanCan::Ability

  def initialize(user)
    user.roles.each do |role|
      alias_action :my_data, :to => :read
      alias_action :my_exams, :to => :read
      alias_action :my_exams, :to => :read
      (can role.action.to_sym, role.controller)
    end
  end
end

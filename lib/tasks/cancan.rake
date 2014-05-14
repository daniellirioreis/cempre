namespace :cancan do
  desc 'Create admin profile'
  task :create_admin_profile => :create_roles do
    Profile.transaction do
      profile = Profile.find_or_create_by_name('ADMINISTRADOR')
      profile.roles = Role.all
    end
  end

  desc 'Purge roles'
  task :purge_roles => :environment do
    Role.transaction do
      roles = YAML.load(File.open("#{Rails.root}/config/roles.yml"))["roles"]

      Role.all.each do |role|
        next if roles.include?("#{role.controller}")

        role.profiles.clear
        role.destroy
      end
    end
  end

  desc 'Create roles'
  task :create_roles => :purge_roles do
    Role.transaction do
      yaml = YAML.load(File.open("#{Rails.root}/config/roles.yml"))

      yaml['actions'].each do |action|
        yaml['roles'].each do |role|
          r = Role.find_by_action_and_controller(action, role)
          unless r.present?
            Role.create(:controller => role, :action => action)
          end
        end
      end
      yaml['actions_more_students'].each do |action|
        r = Role.find_by_action_and_controller(action, 'students')
        unless r.present?
          Role.create(:controller => 'students', :action => action)
        end
      end
      yaml['actions_more_classrooms'].each do |action|
        r = Role.find_by_action_and_controller(action, 'classrooms')
        unless r.present?
          Role.create(:controller => 'classrooms', :action => action)
        end
      end
      yaml['actions_more_calendars'].each do |action|
        r = Role.find_by_action_and_controller(action, 'calendars')
        unless r.present?
          Role.create(:controller => 'calendars', :action => action)
        end
      end
    end
  end
end

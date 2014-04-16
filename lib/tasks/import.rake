require 'csv'
task :import  => :environment do

    a = User.new(:name => ' ADM Cempre', :email => "adm@cempre.com", :password => "inglesespanhol", :password_confirmation => 'inglesespanhol', :profile => "")
     if a.save!
       puts "Usuario criado"
     else
       puts "erro  ao criar usuario"
     end

    @calendar = Calendar.new( name: '1º Semestre de 2014', date_start: "2014-02-15", date_end: "2014-06-12", company_id: Company.first.id )
    if @calendar.save!
      puts "Calendario Criado"
    else
      puts "Erro ao criar calendario"
    end


   CSV.foreach('lib/files_import/levels.csv', headers: true) do |row|
    new_course = Course.new( name: row["NIVEL"].upcase, company_id: Company.first.id , type_course: row["TIPO"].to_i)
     if new_course.save
        puts new_course.inspect
     else
       puts 'error ao criar curso'
     end
    end

    CSV.foreach('lib/files_import/classrooms.csv', headers: true) do |row|
      unless Classroom.find_by_name(row["TURMA"].upcase).present?
        course = Course.find_by_name(row["NIVEL"].upcase)
         if course.present?
            teacher = Teacher.find_by_name(row["PROFESSOR"].upcase)
            unless teacher.present?
              teacher = Teacher.new(name: row["PROFESSOR"].upcase, company_id: Company.first.id)
              teacher.save
            end

            case row["DIA"]
              when 'SAB'
                day = Day::SATURDAY
              when 'SEG/QUA'
                day = Day::MONDAY_AND_WEDNESDAY
              when 'TER/QUI'
                day = Day::TUESDAY_AND_THURSDAY
              when 'QUA'
                day = Day::WEDNESDAY
              when 'SEG'
                day = Day::MONDAY
            end
            hours  = row["HORARIO"].split("-")
            time_start = "#{hours.first.split("H").first.to_i}:#{hours.last.split("H").last.to_i}"
            time_end = "#{hours.last.split("H").first.to_i}:#{hours.last.split("H").last.to_i}"

            new_classroom = Classroom.new( name: row["TURMA"].upcase, company_id: Company.first.id, course_id: course.id , teacher_id: teacher.id, day_week: day, capacity: 15, time_start: time_start, time_end: time_end, calendar_id: @calendar.id)
           if new_classroom.save
             puts new_classroom.inspect
           else
             puts new_classroom.save!
           end
         end
      end
    end

    CSV.foreach('lib/files_import/students.csv', headers: true) do |row|
     birth_date = row['NASCIMENTO'].split('/') unless row["NASCIMENTO"].nil?
     birth_date = "#{birth_date[2]}-#{birth_date[1]}-#{birth_date[0]}" unless row["NASCIMENTO"].nil?
     new_student = Student.find_by_name(row["NOME"].upcase)
      if new_student.present?
        puts "Aluno já existe na base: #{row["NOME"].upcase}"
        new_student.update_attributes(phone: row['TELEFONE'], obs: row["OBS"], document: row["DOCUMENTO"], birth_date: birth_date)
        unless row['TURMA'].nil?
          classroom = Classroom.find_by_name(row['TURMA'].upcase)
          if classroom.present?
            group = Group.new(student_id: new_student.id, classroom_id: classroom.id, status: StatusGroup::ACTIVE)
            if group.save
              puts group.inspect
            else
              puts 'error in group'
            end
          end
        end
      else
        puts "Novo Aluno: #{row["NOME"].upcase}"
        new_student = Student.new( name: row["NOME"].upcase, company_id: Company.first.id, phone: row['TELEFONE'], obs: row["OBS"], document: row["DOCUMENTO"], birth_date: birth_date)
        new_student.email = new_student.default_email
        puts "#{new_student.default_email}"
        if new_student.save!
          puts 'aluno salvo'
          unless row['TURMA'].nil?
            classroom = Classroom.find_by_name(row['TURMA'].upcase)
            if classroom.present?
              group = Group.new(student_id: new_student.id, classroom_id: classroom.id, status: StatusGroup::ACTIVE)
              if group.save
                puts group.inspect
              else
                puts 'error in group'
              end
            end
          end
        else
          puts "error"
        end
      end
    end
end
class TranslateController
  def self.translate(controller)
    case controller
      when 'books'
          'Livros'
      when 'students'
          'Alunos'
      when 'calendars'
          'Períodos'
      when 'notes'
          'Mensagens'
      when 'profiles'
          'Perfis'
      when 'classrooms'
          'Turmas'
      when 'teachers'
          'Professores'
      when 'companies'
          'Escolas'
      when 'courses'
          'Cursos'
      when 'events'
          'Eventos'
      when 'exams'
          'Avaliações'
      when 'faults'
          'Faltas'
      when 'groups'
          'Agrupar Alunos'
      when 'rents'
          'Empréstimos'
      when 'users'
          'Usuários'
      when 'calendar_days'
          'Dias(calendários)'
      when 'questions'
          'Perguntas'
      when 'answers'
          'Respostas'
      when 'questionnaires'
          'Questionários'
      when 'lessons'
        'Aulas'
      when 'birthdays_months'
        'Aniversariantes'
      when 'plans'
        'Cronograma'
      when 'questionnaire_questions'
        'Perguntas do Questionário'
      when 'enrollments'
        'Inscrição'
      when 'managers'
        'Acesso'
      when 'control_points'
        'Controle de Ponto'
    end
  end

  def self.action(action)
    case action
      when 'create'
        'Criar'
      when 'read'
        'Ler'
      when 'update'
        'Atualizar'
      when 'destroy'
        'Apagar'
      when 'schedules'
        'Quadro horários'
      when 'my_data'
        'Minhas informações'
      when 'my_exams'
        'Minhas avaliações'
      when 'events'
        'Eventos'
      when 'finalize'
        'Finalizar'
      when 'bulletin'
        'Boletins'
      when 'generate_lessons'
        'Gerar aulas'
      when 'daily'
        'Diário'
      when 'for_month_print_daily'
        'escolha do mês'
      when 'generate'
        'Gerar questionário'
      when 'down_average'
        'Alunos abaixo da média'
      when 'schedules_for_week_day'
        'Horários por dia da semana'
      when 'declaration_of_studying'
        'Declaração de Cursando'
      when 'second_change_exam'
        '2ª chamada prova'
      when 'print'
        'Imprimir'
      when 'returned'
        'Devolver'
      when 'classrooms'
        'Turmas'
      when 'results'
        'Resultados'
      when 'throw_faults'
        'Lançar faltas'
      when 'create_with_click'
        'Criar Faltas'
      when 'change_companies'
        'Trocar de escola'
      when 'create_calendar'
        'Criar período'
      when 'change_calendars'
        'Trocar período'
      when 'frequency'
        'Frequência'
      when 're_enrollment'
        'Rematricula'
      when 're_enrollments'
        'Rematriculas'
      when 'report_re_enrollments'
        'Imprimir Rematriculas'
      when 'report'
        'Imprimir'
      when 'have_book'
        'Pedido de livro'
      when 'buy_books'
        'Pedido de livro'      
      when 'info'
        'Controle de Ponto'      
      when 'throw_exams'
        'Lançar notas'      
      when 'report_schedules' 
        'Relatório Quadro de Horarios'
      when 'report_teacher'
        'Relatório Professor'
      when 'list_classrooms_to_re_enrollments'
        'Listagem de turmas para rematrículas'
      when 'create_re'
        'Criar rematrícula'     
      when 'envelopes_for_exams'
        'Envelopes para provas'
    end
  end
end
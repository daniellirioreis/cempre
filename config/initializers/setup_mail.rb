ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
:address => "smtp.gmail.com",
:port => 587,
:domain => "cempre.herokuapp.com",
:user_name => "cemprecruzeiro@gmail.com",
:password => "inglesespanhol",
:authentication => "plain",
:enable_starttls_auto => false
}
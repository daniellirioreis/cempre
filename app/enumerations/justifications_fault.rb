class JustificationsFault < EnumerateIt::Base
  associate_values :none                => 0,
                   :declaration         => 1,
                   :medical_certificate => 2,
                   :others              => 3
end
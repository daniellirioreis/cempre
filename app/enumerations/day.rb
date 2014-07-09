class Day < EnumerateIt::Base
  associate_values :monday_and_wednesday                => 0,
                   :tuesday_and_thursday                => 1,
                   :saturday                            => 2,
                   :wednesday                           => 3,
                   :monday                              => 4,
                   :thursday                            => 5


end
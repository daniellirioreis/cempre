class StatusGroup < EnumerateIt::Base
  associate_values :active                => 0,
                   :transfer              => 1,
                   :locked                => 2,
                   :folded                => 3,
                   :approved              => 4,
                   :failed                => 5

end
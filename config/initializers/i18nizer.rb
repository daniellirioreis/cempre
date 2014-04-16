class String
  def i18nize!
    gsub! /\//, "."
  end
  alias_method :i18ncase!, :i18nize!

  def i18nize
    dup.tap {|_| _.i18nize! }
  end
  alias_method :i18ncase, :i18nize
end

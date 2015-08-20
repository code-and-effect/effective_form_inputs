module EffectiveFormInputsHelper
  def price_to_currency(price)
    price = price || 0
    raise 'price_to_currency expects an Integer representing the number of cents' unless price.kind_of?(Integer)
    number_to_currency(price / 100.0)
  end
end

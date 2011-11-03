module SymbolizeAttribute

  def symbolize_attribute(attribute)
    attribute = attribute.to_sym
    define_method(attribute) do
      read_attribute(attribute).try(:to_sym)
    end

    define_method("#{attribute.to_s}=".to_sym) do |status|
      write_attribute(attribute, status.try(:to_s))
    end
  end

end
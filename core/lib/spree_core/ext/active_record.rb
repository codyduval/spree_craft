module ActiveRecord::Persistence

  # Update attributes of a record in the database without callbacks, validations etc.
  def update_attributes_without_callbacks(attributes)
    self.assign_attributes(attributes, :without_protection => true)
    self.class.where(:id => id).update_all(attributes)
  end

  # Update a single attribute in the database
  def update_attribute_without_callbacks(name, value)
    send("#{name}=", value)
    update_attributes_without_callbacks(name => value)
  end

end

module ActiveRecord
  module Inheritance
    extend ActiveSupport::Concern

    module ClassMethods
      # Determines if one of the attributes passed in is the inheritance column,
      # and if the inheritance column is attr accessible, it initializes an
      # instance of the given subclass instead of the base class
      def subclass_from_attrs(attrs)
        subclass_name = attrs.with_indifferent_access[inheritance_column]

        if subclass_name.present? && subclass_name != self.name
          subclass = subclass_name.safe_constantize

          unless descendants.include?(subclass)
            raise ActiveRecord::SubclassNotFound.new("Invalid single-table inheritance type: #{subclass_name} is not a subclass of #{name}")
          end

          subclass
        end
      end
    end
  end
end
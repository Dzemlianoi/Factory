class Factory
  def self.new(*attrs, &block)
    Class.new do
      attr_accessor(*attrs)

      define_method :attributes do
        attrs
      end

      def initialize(*values)
        raise 'Argument Error' if values.count != attributes.count
        ziped = attributes.zip(values)
        ziped.each do |k, v|
          instance_variable_set("@#{k}", v)
        end
      end

      def [](arg)
        if  arg.is_a? Fixnum
          inst = instance_variables[arg]
        else
          inst = "@#{arg}"
        end
        instance_variable_get inst
      end

      class_eval(&block) if block_given?
    end
  end
end

Job = Factory.new(:spesialization, :salary, :work_hours, :cookies)
programmer = Job.new('developer', 1, 9, true)

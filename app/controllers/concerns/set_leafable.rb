module SetLeafable
  extend ActiveSupport::Concern

  included do
    before_action :set_leaf, :set_leafable, only: %i[ show edit update destroy ]
  end

  private
    def set_leaf
      @leaf = @book.leafs.public_send(controller_recordable_name.pluralize).find params[:id]
    end

    def set_leafable
      @leafable = @leaf.leafable
      instance_variable_set "@#{controller_recordable_name}", @leafable
    end

    def controller_leafable_name
      self.class.to_s.remove("Controller").demodulize.singularize.underscore
    end
end

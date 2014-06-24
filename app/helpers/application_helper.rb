module ApplicationHelper

  def bootstrap_class_for(type)
    case type.to_sym
      when :success
        'alert-success'
      when :error
        'alert-danger'
      when :alert
        'alert-warning'
      when :notice
        'alert-info'
      else
        type.to_s
    end
  end

end

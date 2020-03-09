module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'alert'
      'alert-danger'
    when 'notice'
      'alert-success'
    else
      flash_type.to_s
    end
  end
end

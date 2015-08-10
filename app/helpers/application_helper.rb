module ApplicationHelper

  def script_template(*args)
    name    = args.first
    options = args.second || {}
    id      = options[:id] || "backbone_templates_#{controller_name}_#{name}"
    locals  = options[:locals] || {}
    partial = options[:partial] || "#{controller_name}/#{name}"
    id = id.camelize(:lower)
    content_tag(:script, :type => "text/template", :id => id) do
      render :partial => partial, :locals => locals
    end
  end

  FLASH_NOTICE_KEYS = [:error, :notice, :warning, :alert, :success]

  def flash_messages
    return unless messages = flash.keys.select{|k| FLASH_NOTICE_KEYS.include?(k)}
    formatted_messages = messages.map do |type|
      content_tag :div, :class => "alert alert-#{type.to_s}" do
        message_for_item(flash[type], flash["#{type}_item".to_sym])
      end
    end
    flash.discard
    raw formatted_messages.join
  end

  def message_for_item(message, item = nil)
    msg = "#{link_to('x', '#', :class => 'close', :"data-dismiss" => "alert")}"
    if item.is_a?(Array)
      msg << content_tag(:p) do
        message % can_link_to(*item)
      end
    else
      msg << content_tag(:p) do
        message % item
      end
    end
    raw msg
  end

  def title_page
    'Certificados Orbe'
  end

  def habtm_checkboxs(model, collection, *args)
    options          = args.first || {}
    per_row          = options[:per_row] || 4
    attribute        = options[:attribute] || "id"
    check_box_name   = options[:check_box_name]
    model_klass_name = model.class.model_name.underscore

    container  = ""
    columns    = ""
    span_with  = (12 / per_row).to_i

    collection.each do |object|
      nested_klass_name = object.class.model_name.underscore
      value             = object[attribute]
      check_box_name  ||= "#{model_klass_name}[#{nested_klass_name}_ids][]"

      columns << content_tag(:div, :class => "span#{span_with}", :id => "#{nested_klass_name}_#{value}") do
        raw %{<div class='control-group'>
                <label for='#{model_klass_name}_#{nested_klass_name}_ids_#{value}' class='checkbox inline'>
                  #{check_box_tag check_box_name, value, false, :id => "#{model_klass_name}_#{nested_klass_name}_ids_#{value}"}
                  #{object.name}
                </label>
              </div>
             }
      end
    end
    container << content_tag(:div, raw(columns), :class => "row") unless columns.blank?
    raw container
  end

  def icon_image *args
    name    = args.first  || "plus"
    options = args.second || {}

    unless options[:confirm].blank?
      options[:"data-confirm"] = options[:confirm]
      options.delete :confirm
    end

    options[:title] ||= t("icons.#{name}")
    options[:class]   = "icon-#{name} #{options[:class]}"

    content_tag :i, nil, options
  end
  
end

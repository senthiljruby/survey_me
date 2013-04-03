module ApplicationHelper
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', :class => "btn btn-primary add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def menu_list(menu_name)
    controller = params[:controller]
    action = params[:action]
    active = case menu_name
              when 'home'
                controller == 'home' && (action == 'index')
              when 'survey'
                controller == 'surveys' && (action != 'results')
             end
    'active' if active
  end
end

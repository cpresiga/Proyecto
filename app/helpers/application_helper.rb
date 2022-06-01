module ApplicationHelper
    include Pagy::Frontend

    def model_name (model, pluralize: false)
        model.model_name.human(count: pluralize ? 2 : 1)
    end 
end

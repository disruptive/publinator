require_dependency "publinator/application_controller"


class StandardController < Publinator::ApplicationController

  layout :current_layout
  before_filter :in_a_site

  def search
    render :text => "Searching now..."
  end

end



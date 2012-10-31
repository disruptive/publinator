class Publinator::ManageController < Publinator::ApplicationController
  layout 'publinator/manage'
  #before_filter :managers_only

  # def managers
  #   if
  # end

  def index
    @publishable_types = Publinator::PublishableType.all
    render "publinator/manage/index"
  end

end

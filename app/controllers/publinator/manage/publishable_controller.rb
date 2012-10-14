require_dependency "publinator/application_controller"

module Publinator
  class Manage::PublishableController < ApplicationController
    layout "publinator/manage"

    def index
      @publishables = Publinator::Publication.for_site(current_site.id).where(:publishable_type => params["publishable_type"].singularize.capitalize).order("updated_at desc")
      begin
        render "manage/#{params[:publishable_type]}/index"
      rescue ActionView::MissingTemplate
        render "publinator/manage/publishable/index"
      end
    end

    def show
      @publication = Publinator::Publication.find_by_publishable_type_and_slug(params[:publishable_type].singularize.capitalize, params[:id])
      @publishable = @publication.publishable_type.singularize.capitalize.constantize.send(:find, @publication.publishable_id)
      begin
        render "#{params[:publishable_type]}/show"
      rescue ActionView::MissingTemplate
        render "publinator/manage/publishable/show"
      end
    end

    def new
      publishable_class = params['publishable_type'].singularize.capitalize.constantize
      #@publication = Publinator::Publication.find_by_publishable_type_and_publishable_id(params[:publishable_type].singularize.capitalize, params[:id])
      @publishable = publishable_class.send(:new, {
        :publication => Publinator::Publication.new(
          :publish_at => 1.day.from_now.beginning_of_day + 8.hours,
          :archive_at => 31.days.from_now.beginning_of_day,
          :site_id    => current_site.id
        )
      })
      @field_names = (publishable_class.attribute_names - ["id", "created_at", "updated_at"]).collect{ |an| an.to_sym }
      begin
        render "#{params[:publishable_type]}/new"
      rescue ActionView::MissingTemplate
        render "publinator/manage/publishable/new"
      end
    end

    def edit
      @publication = Publinator::Publication.find_by_publishable_type_and_slug(params[:publishable_type].singularize.capitalize, params[:id])
      @publishable = @publication.publishable_type.singularize.capitalize.constantize.send(:find, @publication.publishable_id)
      begin
        render "#{params[:publishable_type]}/edit"
      rescue ActionView::MissingTemplate
        render "publinator/manage/publishable/edit"
      end
    end

    def create
      @publishable_type = PublishableType.find_by_name(params['publishable_type'].singularize.capitalize)
      @publishable_class = @publishable_type.name.capitalize.constantize
      publishable_params = params[@publishable_type.name.downcase.to_sym]
      publication_params = publishable_params.delete('publication').merge({ :site_id => current_site.id, :publishable_type => @publishable_type.name.capitalize })
      @publication = Publinator::Publication.create!(publication_params)
      @publishable = @publishable_type.name.capitalize.constantize.send(:new, publishable_params, :publication => @publication)

      if @publishable.save
        @publication.publishable_id = @publishable.id
        @publication.save
        redirect_to "/manage/#{params[:publishable_type]}", :notice => "#{@publishable_type.name} created."
      else
        begin
          render "#{params[:publishable_type]}/new", :notice => "#{@publishable_type.name} could not be created."
        rescue ActionView::MissingTemplate
          render "publinator/manage/publishable/new", :notice => "#{@publishable_type.name} could not be created."
        end
      end
    end
  end
end

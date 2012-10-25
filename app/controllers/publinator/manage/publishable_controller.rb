require_dependency "publinator/application_controller"

module Publinator
  class Manage::PublishableController < ApplicationController
    layout "publinator/manage"

    before_filter :get_publishable

    def index
      begin
        render "manage/#{@publishable_collection_name}/index"
      rescue ActionView::MissingTemplate
        render "publinator/manage/publishable/index"
      end
    end

    def show
      begin
        render "manage/#{@publishable_collection_name}/show"
      rescue ActionView::MissingTemplate
        render "publinator/manage/publishable/show"
      end
    end

    def new
      @publishable = @publishable_class.new(
        :publication => Publinator::Publication.new(
          :publish_at       => 1.day.from_now.beginning_of_day + 8.hours,
          :archive_at       => 31.days.from_now.beginning_of_day,
          :site             => current_site,
          :publishable_type => @publishable_type.name
        )
      )
      @publishable.asset_items.build
      @field_names = @publishable.editable_fields.collect{ |an| an.to_sym }
      begin
        render "manage/#{@publishable_collection_name}/new"
      rescue ActionView::MissingTemplate
        render "publinator/manage/publishable/new"
      end
    end

    def edit
      @publishable.asset_items.build

      begin
        render "manage/#{@publishable_collection_name}/edit"
      rescue ActionView::MissingTemplate
        render "publinator/manage/publishable/edit"
      end
    end

    def create
      @publishable = @publishable_class.new(params[@publishable_member_name.to_sym])
      logger.info current_site.to_yaml
      @publishable.publication.site = current_site

      if @publishable.save
        redirect_to "/manage/#{@publishable_collection_name}", :notice => "#{@publishable_type.name} created."
      else
        begin
          render "#{@publishable_collection_name}/new", :notice => "#{@publishable_type.name} could not be created."
        rescue ActionView::MissingTemplate
          render "publinator/manage/publishable/new", :notice => "#{@publishable_type.name} could not be created."
        end
      end
    end

    def update
      if @publishable_class.send(:update, @publishable.id, params[@publishable_class_name.downcase.to_sym])
        redirect_to "/manage/#{@publishable_collection_name}", :notice => "#{@publishable_type.name} updated."
      else
        begin
          render "#{@publishable_collection_name}/edit", :notice => "#{@publishable_type.name} could not be updated."
        rescue ActionView::MissingTemplate
          render "publinator/manage/publishable/edit", :notice => "#{@publishable_type.name} could not be updated."
        end
      end
    end

    def sort
      collection_class = @publishable.collection_name.singularize.downcase
      @publishable.menu_collection.each do |item|
        item.position = params[collection_class].index(item.id.to_s) + 1
        item.save
      end
      render :nothing => true
    end


    private

      def get_publishable
        if params["publishable_type"].nil?
          @publishable_class_name = "Page"
          @publishable_collection_name = "pages"
          @publishable_class = Publinator::Page
          @publishable_type = PublishableType.find_by_name("Publinator::Page")
          @publishable_type_name = @publishable_type.name
        else
          @publishable_class_name = params["publishable_type"].classify
          @publishable_collection_name = params["publishable_type"]
          @publishable_member_name =  params["publishable_type"].singularize.downcase
          @publishable_class = @publishable_class_name.constantize
          @publishable_type = PublishableType.find_by_name(params['publishable_type'].classify)
          @publishable_type_name = @publishable_type.name
        end

        @publications = Publinator::Publication.for_site(current_site.id).where(:publishable_type => @publishable_type.name).order("updated_at desc")
        @publishables = @publications.collect{ |pub| pub.publishable }
        if params[:id]
          original_id = params[:id]
          if original_id.to_i.to_s == params[:id]
            @publishable = @publishable_class.send(:find, params[:id])
            @publication = @publishable.publication
          else
            @publication = @publications.find(:first, :conditions => ["slug = ?", params[:id]])
            @publishable = @publication.publishable
          end
        end
      end
  end
end

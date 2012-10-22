require_dependency "publinator/application_controller"

module Publinator
  class Manage::PagesController < Publinator::ManageController
    layout "publinator/manage"

    before_filter :get_pages
    before_filter :get_page, :only => [:show, :edit, :update, :destroy]

    def index
      begin
        render "manage/pages/index"
      rescue ActionView::MissingTemplate
        render "publinator/manage/pages/index"
      end
    end

    def show
      begin
        render "manage/pages/show"
      rescue ActionView::MissingTemplate
        render "publinator/manage/pages/show"
      end
    end

    def new
      @page = Publinator::Page.send(:new, {
        :publication => Publinator::Publication.new(
          :publish_at       => 1.day.from_now.beginning_of_day + 8.hours,
          :archive_at       => 31.days.from_now.beginning_of_day,
          :site             => current_site,
          :publishable_type => "Publinator::Page"
        )
      })
      @page.asset_items.build
      @field_names = @page.editable_fields.collect{ |an| an.to_sym }
      begin
        render "manage/pages/new"
      rescue ActionView::MissingTemplate
        render "publinator/manage/pages/new"
      end
    end

    def edit
      @field_names = @page.editable_fields.collect{ |an| an.to_sym }
      @page.asset_items.build
      begin
        render "manage/pages/edit"
      rescue ActionView::MissingTemplate
        render "publinator/manage/pages/edit"
      end
    end

    def create
      @page = Publinator::Page.new(params[:page])
      @page.site = current_site
      if @page.save
        redirect_to "/manage/pages", :notice => "Page created."
      else
        begin
          render "manage/pages/new", :notice => "Page could not be created."
        rescue ActionView::MissingTemplate
          render "publinator/manage/pages/new", :notice => "Page could not be created."
        end
      end
    end

    def update
      @page.update_attributes(params[:page])
      @page.site = current_site
      if @page.save
        redirect_to "/manage/pages", :notice => "Page updated."
      else
        begin
          render "manage/page/edit", :notice => "Page could not be updated."
        rescue ActionView::MissingTemplate
          render "publinator/manage/pages/edit", :notice => "Page could not be updated."
        end
      end
    end

    private

      def get_pages
        @pages = Publinator::Page.where(:site_id => current_site.id).order("updated_at desc")
      end

      def get_page
        @page = @pages.find(params[:id])
      end
  end
end

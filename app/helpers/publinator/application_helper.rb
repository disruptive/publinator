module Publinator
  require 'rdiscount'

  module ApplicationHelper
    def link_to_page(link_text, section, slug)
      link_to link_text, "/#{section}/#{slug}"
    end

    def m(markdown_text)
      return if !markdown_text || markdown_text.blank?
      RDiscount.new(markdown_text).to_html.html_safe
    end

    def menu_item(object)
      if object.respond_to?(:is_publishable?)
        li_tag(object)
      else
        collection_li_tag(object)
      end
    end

    def collection_li_tag(object, li_collection_title = nil, li_collection_path = nil)
      return if object.respond_to?(:hide_in_submenu) && object.hide_in_submenu
      collection_title = li_collection_title.present? ? li_collection_title : object.first.collection_name
      collection_slug  = object.first.class.to_s.tableize.humanize
      collection_path  = li_collection_path.present? ? li_collection_path : "/#{object.first.class.to_s.tableize}"

      # object is an array
      #   1. add a link to the collection name
      #   2. add a ul for the collection
      #   3. add li tags for each object in the collection


      content_tag(:li, :id => object.first.class.to_s.tableize) do
        li_content = ""
        li_content += link_to collection_title, collection_path


        li_content += content_tag(:div, :class => 'submenu', :id => object.first.class.to_s.tableize) do
          div_contents = ""
          div_contents += content_tag(:ul) do
            next_contents = ""
            object.each do |o|
              next_contents += li_tag(o) unless o.respond_to?(:hide_in_submenu) && o.hide_in_submenu
            end
            next_contents.html_safe
          end
          div_contents.html_safe
        end

        li_content.html_safe
      end
    end

    def li_tag(object)
      content_tag(:li, :id => object.my_slug) do
        li_content = ""
        li_content += link_to object.title, object.path
        if object.menu_collection && object.menu_collection.length > 0
          li_content += ("<br>" + submenu(object).html_safe)
        end
        li_content.html_safe
      end
    end

    def submenu(object)
      content_tag(:div, :class => 'submenu', :id => object.slug) do
        div_content = ""
        ul_content = ""
        div_content += content_tag(:ul) do
          object.menu_collection.each do |mco|
            unless mco.respond_to?(:hide_in_submenu) && mco.hide_in_submenu
              ul_content += li_tag(mco)
            end
          end
          ul_content.html_safe
        end
        div_content.html_safe
      end
    end

    def publishable_asset(pub, asset_type)
      return if !pub
      asset = pub.asset_file(asset_type)
      image_tag asset.url if asset
    end

    def asset_file_tag(object, asset_type, size = 'original', img_class = nil)
      imgs = object.asset_files(asset_type)
      return unless imgs && imgs.first
      if img_class
        image_tag(imgs.first.asset.url(size.to_sym), :class => img_class)
      else
        image_tag(imgs.first.asset.url(size.to_sym))
      end
    end
  end
end

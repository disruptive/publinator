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

    def menu_section(title, path = "", collection)
      if path.blank?
        ct = "
        <li id=\"#{title.underscore}\">#{title}<br>\n"
      else
        ct = "
        <li id=\"#{title.underscore}\"><a href='#{path}'>#{title}</a><br>\n"
      end
      if collection && collection.length && collection.length > 0
        ct += "<div class='submenu'>
        <ul>"
        collection.each do |c|
          ct += menu_section(c.title, c.path, c.menu_collection)
        end
        ct += "</ul>
        </div>"
      end
      ct += "</li>"
      ct.html_safe
    end


    def menu_item(object)
      if object.respond_to?(:is_publishable?)
        li_tag(object)
      else
        collection_li_tag(object)
      end
    end

    def collection_li_tag(object)
      collection_title = object.first.collection_name
      collection_slug  = object.first.class.to_s.tableize.humanize
      collection_path  = "/#{object.first.class.to_s.tableize}"

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
              next_contents += li_tag(o)
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
      obj_slug = object.respond_to?(:slug) ? object.slug : object.my_slug
      content_tag(:div, :class => 'submenu', :id => obj_slug) do
        div_content = ""
        ul_content = ""
        div_content += content_tag(:ul) do
          object.menu_collection.each{ |mco| ul_content += li_tag(mco) }
          ul_content.html_safe
        end
        div_content.html_safe
      end
    end

    #def menu_item(obj)
      #menu_section(obj.title, obj.path, obj.menu_collection)
    #end

    def publishable_asset(pub, asset_type)
      return if !pub
      asset = pub.asset_file(asset_type)
      image_tag asset.url if asset
    end
  end
end

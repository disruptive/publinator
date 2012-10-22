module Publinator
  require 'rdiscount'

  module ApplicationHelper
    def link_to_page(link_text, section, slug)
      link_to link_text, "/#{section}/#{slug}"
    end

    def m(markdown_text)
      RDiscount.new(markdown_text).to_html.html_safe
    end

    def menu_section(title, path = "", collection)
      if path.blank?
        ct = "<li>#{title}<br>"
      else
        ct = "<li><a href='#{path}'>#{title}</a><br>"
      end
      if collection && collection.length && collection.length > 0
        ct += "<div class='submenu'><ul>"
        collection.each do |c|
          ct += menu_section(c.title, c.path, c.menu_collection)
        end
        ct += "</ul></div>"
      end
      ct += "</li>"
      ct.html_safe
    end

    def menu_item(obj)
      menu_section(obj.title, obj.path, obj.menu_collection)
    end

    def publishable_asset(pub, asset_type)
      return if !pub
      asset = pub.asset_file(asset_type)
      image_tag asset.url if asset
    end
  end
end

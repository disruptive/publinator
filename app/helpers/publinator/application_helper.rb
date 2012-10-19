module Publinator
  require 'rdiscount'

  module ApplicationHelper
    def link_to_page(link_text, section, slug)
      link_to link_text, "/#{section}/#{slug}"
    end

    def m(markdown_text)
      RDiscount.new(markdown_text).to_html.html_safe
    end

    def menu(array)
      menu = content_tag(:ul, :class => 'nav_menu') do
        menu_content = ""
        array.each do |obj|
          menu_content += menu_item(obj)
        end
        menu_content.html_safe
      end
      menu.html_safe
    end

    def menu_item(obj)
      logger.info "ready to create entry for #{obj.class} #{obj.id}"
      if obj.class == Publinator::Publication
        logger.info "publication's publishable is #{obj.publishable.class} #{obj.publishable.id}"
      end
      raise "No publishable found for #{obj.class} #{obj.id}" if !obj.publishable
      tag_content = content_tag(:li) do
        li_content = link_to obj.publishable.title, obj.publishable.path
        if obj.respond_to? :publications
          li_content += content_tag(:div, :class => "submenu") do
            if obj.publications && obj.publications.length && obj.publications.length > 0
              submenu_content = content_tag(:ul) do
                sub_content = ""
                obj.publications.each do |pub|
                  logger.info "ready to create entry for #{pub.publishable_type} #{pub.publishable_id} #{pub.slug}"
                  unless pub.slug == 'index'
                    sub_content += menu_item(pub)
                  end
                end
                sub_content.html_safe
              end
              li_content += submenu_content
            end
          end
        end
        li_content.html_safe
      end
      tag_content
    end
  end
end

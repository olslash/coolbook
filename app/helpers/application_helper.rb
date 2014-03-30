module ApplicationHelper

  def full_title(page_title)
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  #http://stackoverflow.com/questions/5809917/conditional-tag-wrapping-in-rails-erb
  def conditional_wrapper(condition=true, options={}, &block)
    options[:tag] ||= :div
    if condition
      concat content_tag(options[:tag], capture(&block), options.delete_if{|k,v| k == :tag})
    else
      concat capture(&block)
    end
  end
end

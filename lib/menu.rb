class Menu < ActionView::AbstractRenderer

  def self.create(renderer, *args, &block)
    options = args.extract_options!
    depth = args.first || 0

    menu = new depth, options

    yield(menu)

    menu.render renderer
  end

  def item(*args, &block)
    options      = args.extract_options!
    id           = options.delete(:id)
    icon         = options.delete(:icon)
    path         = options.delete(:path)
    active       = %w(1 true).include? options.delete(:active).to_s
    options_menu = options.delete(:options_menu) || {}

    label = I18n.t("menu.#{id}", :default => "#{id}".humanize)
    model_name = "#{id}".camelize.singularize

    if Object.const_defined? model_name
      label = model_name.constantize.model_name.human
    end

    item = {
      :label => label,
      :icon => icon,
      :path => path,
      :active => active,
      :submenu => nil,
      :options_link => {}
    }

    if block_given?
      if @depth > 0
        item[:path]  = "#"
        item[:options_link][:class]  = "dropdown-toggle"
        item[:options_link][:"data-toggle"]  = "dropdown"

        options_menu = @options.dup.merge(options_menu)
        submenu      = self.class.new @depth - 1, options_menu

        yield(submenu)

        item[:submenu] = submenu
      else
        raise ArgumentError, "Unable to add a submenu, the depth has been reached."
      end
    end

    @items << item
    nil
  end

  def render(renderer)
    renderer.content_tag :ul, :class => @options[:class], :id => @options[:id] do
      @items.map do |item|
        has_submenu = item[:submenu].present?

        li_options         = {}
        li_options[:class] = "active" if item[:active]

        link_html = "".tap do |html|
          html << renderer.content_tag(:i, nil, :class => "icon-#{item[:icon]} icon") + "\n" if item[:icon]

          html << renderer.content_tag(:span, :class => "sidebar-text") do
            span_html = "#{item[:label]}\n"
            span_html << renderer.content_tag(:i, nil, :class => "icon-chevron pull-right") + "\n" if has_submenu
            span_html.html_safe
          end + "\n"

        end.html_safe

        li_html = renderer.link_to(link_html, item[:path], item[:options_link]).html_safe
        li_html << item[:submenu].render(renderer).html_safe + "\n" if has_submenu

        renderer.content_tag(:li, li_html, li_options)
      end.join("\n").html_safe
    end
  end

  private

  def initialize(depth, options)
    @depth = depth
    @options = options
    @items = []
  end
end

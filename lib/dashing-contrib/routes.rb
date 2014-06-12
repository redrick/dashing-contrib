require 'sinatra'

get '/views/:widget?.html' do
  protected!
  tilt_html_engines.each do |suffix, engines|
    widget_name = params[:widget]
    file_name   = "#{widget_name}.#{suffix}"
    file_overrides = File.join(settings.root, 'widgets', widget_name, file_name)
    return engines.first.new(file_overrides).render if File.exist? file_overrides

    contrib_file = File.join(__dir__, 'assets', 'widgets', widget_name, file_name)
    return engines.first.new(contrib_file).render if File.exist? contrib_file
  end
end
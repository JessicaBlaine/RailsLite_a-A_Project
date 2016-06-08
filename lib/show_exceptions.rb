require 'erb'
require 'byebug'

class ShowExceptions
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      app.call(env)
    rescue StandardError => e
      render_exception(e)
    end
  end

  private

  def render_exception(e)
    res = Rack::Response.new
    res.status = "500"
    res["Content-type"] = "text/html"

    erb = ERB.new(File.read("lib/templates/rescue.html.erb"))
    res.write(erb.result(binding))

    res.finish
  end

end

require 'byebug'

class Static
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    if req.path.match(/public\/.*/)
      serve_asset(req)
    else
      @app.call(env)
    end
  end

  private

  def serve_asset(req)
    res = Rack::Response.new
  
  begin
    match_data = req.path.match(/(?<file_path>public\/.*)/)
    res.write(File.read(match_data[:file_path]))
  rescue
    res.status = "404 file not found"
  end

    res.finish
  end
end

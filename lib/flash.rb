require 'json'

class Flash
  def initialize(req)
    cookie = req.cookies["_rails_lite_app_flash"]
    @flash = JSON.parse(cookie) if cookie
    @flash ||= {}
    @now = {}
  end

  def [](key)
    @flash[key] || @now[key]
  end

  def []=(key, val)
    @flash[key] = val
  end

  def store_flash(res)
    # delete all vals from flash.now
    res.set_cookie("_rails_lite_app_flash", path: "/", value: @flash.to_json)
  end

  def now
    @now ||= {}
  end
end

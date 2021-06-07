module BasicPathSupport
  def basic_pass(path)
    username = ENV["BASIC_AUTH_FURIMA_USER"]
    password = ENV["BASIC_AUTH_FURIMA_PASSWORD"]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end
end
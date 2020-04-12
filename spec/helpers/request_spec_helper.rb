module RequestSpecHelper

  # utility function for read response body as json
  def json
    JSON.parse(response.body)
  end
end

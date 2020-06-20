module RequestSpecJsonResponse
  def response_json
    Oj.load(response.body, {})
  end

  def response_data
    response_json['data']
  end
end

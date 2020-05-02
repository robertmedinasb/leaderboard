require 'http'
require 'json'

class Requests
  attr_accessor :base_request, :api_base, :api_pr

  def initialize(owner = "codeableorg", repo = "week-2-extended-project")
    @base_request = HTTP.headers(accept: "application/json")
    @api_base = "https://api.github.com/repos/#{owner}/#{repo}"
    @api_pr = api_base + "/pulls"
  end

  def return_api(api)
    api.code == 200 ? api.parse : []
  end

  def list_pr
    return_api(base_request.get(api_pr))
  end

  def list_ids
    return_api(base_request.get(api_pr)).map{|pr| pr['number']}
  end

  def commits
    list_pr.map {|pr| pr.each{}}
  end

end

try = Requests.new
try.commits

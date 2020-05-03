require 'http'
require 'json'
require 'yaml'


class Requests
  attr_accessor :base_request, :api_base, :api_pr

  def initialize(owner = "codeableorg", repo = "week-2-extended-project")
    @base_request = HTTP.basic_auth(user: 'robertmedinasb', pass: 'robertmedinasb26527325').headers(accept: "application/json")
    @api_base = "https://api.github.com/repos/#{owner}/#{repo}"
    @api_pr = api_base + "/pulls"
    @owner = owner
    @repo = repo
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
  
  def create_commits_files
    list_ids.each {|pr| return_commits(pr)}
  end

  def create_reviews_files
    list_ids.each {|pr| return_reviews(pr)}
  end

  def return_commits(pr_number)
    commit = return_api(base_request.get(api_pr+"/#{pr_number}/commits"))
    File.open("commits/pr_#{pr_number}_commits.json","w") do |f|
      f.write(commit.to_json)
    end
  end

  def return_reviews(pr_number)
    reviews = return_api(base_request.get(api_pr+"/#{pr_number}/comments"))
    File.open("comments/pr_#{pr_number}_comments.json","w") do |f|
      f.write(reviews.to_json)
    end
  end
  
  def save
    create_commits_files
    create_reviews_files
    save = {time: Time.now ,owner: @owner , repo: @repo}
    File.open("save.yml","w") do |f|
      f.write(save.to_yaml)
    end
  end

end

# review_comments https://api.github.com/repos/codeableorg/week-2-extended-project/pulls/34/comments 
# issue_comments https://api.github.com/repos/codeableorg/week-2-extended-project/issues/34/comments 
require_relative 'requests'

class ProcessData
  def initialize(owner = 'codeable', repo = 'week-2-extended-project')
    @owner = owner
    @repo = repo
  end

  def commit(file_pr)
    pr_number = JSON.parse(File.read("commits/#{file_pr}"))
     commiters = pr_number.map do |commit|
      begin
        commit['author']['login']
      rescue
        commit['commit']['author']['name']
      end

    end.uniq
    commiters
  end

  def contribuitors (file_pr)
    pr_number = JSON.parse(File.read("commits/#{file_pr}"))
    contribuitors = pr_number.map do |comment|
      begin
        comment['author']['login']
      rescue
        comment['commit']['author']['name']
      end

    end.uniq
    contribuitors
  end

end

test = ProcessData.new
test.contribuitors
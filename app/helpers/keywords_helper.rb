module KeywordsHelper
  def getsearch
    @search.nil? ? Search.new : @search
  end
end

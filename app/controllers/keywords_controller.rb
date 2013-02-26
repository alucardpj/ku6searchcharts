class KeywordsController < ApplicationController
  def query
    q = params['q']
    result = Keyword.where(keyword: q)
    data = result.map { |node| [node.date, node.count] }.sort { |a, b| a[0] <=> b[0] }.transpose
    @h1 = LazyHighCharts::HighChart.new('graph') do |f|
        f.title({ :text=> q})
        f.options[:xAxis][:categories] = data[0]
        f.series(:type=> 'spline',:name=> q,:data=> data[1])
        f.plot_options( :spline => {
          :dataLabels => {
            :enabled => true
          }})
        f.tooltip( :crosshairs => true, :shared => true)
    end
  end
end

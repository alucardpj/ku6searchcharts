class KeywordsController < ApplicationController
  def query
    if !params['q'].nil?
      qs = params['q'].split
      xaxis = []
      resulthash = Hash.new
      qs.each do |q|
        result = Keyword.where(keyword: q)
        temphash = Hash.new
        result.each { |node| temphash[node.date] = node.count }
        xaxis |= temphash.keys
        resulthash[q] = temphash
      end
      xaxis.each do |category|
        resulthash.each_value do |value|
          if value[category].nil?
            value[category] = 0
          end
        end
      end
      @h1 = LazyHighCharts::HighChart.new('graph') do |f|
        f.title({ :text => params['q']})
        f.options[:xAxis][:categories] = xaxis.sort { |a, b| a <=> b }
        resulthash.each do |keyword, counthash|
          count = counthash.to_a.sort { |a, b| a[0] <=> b[0] }.transpose[1]
          f.series(:type => 'spline', :name => keyword, :data => count)
        end
        f.plot_options( :spline => {
          :dataLabels => {
          :enabled => true
        }})
        f.tooltip( :crosshairs => true, :shared => true)
      end
    end
  end
end

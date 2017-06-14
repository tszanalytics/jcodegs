# function to plot histogram and density on same figure
using Distributions, Plots, PlotRecipes
# mcs = sample to plot (MC sample or whatever)
function plot_den_hist(mcs; bins = 100)
  hh = hist(mcs, bins)
  histFreq = hh[2]
  histXout = hh[1]
  binWidth = histXout[2]-histXout[1]
  bar(histXout, histFreq/binWidth/sum(histFreq), gridcolor=:lightgrey,label="histogram")
  plot!(mcs, st=:density, linecolor = "purple" , label="density")
end

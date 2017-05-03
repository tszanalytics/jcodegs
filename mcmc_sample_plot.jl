#### Requires Plots, PlotRecipes: before calling function:
#### using Plots, PlotRecipes

# to save plot, after calling function: png("filename")

# mcs = an MCMC sample (a vector)
function mcmc_sample_plot(mcs)
    plot(  plot(mcs,label=""),
    plot(mcs, st=:density, gridcolor=:lightgrey,label="density"),
    layout = 2)
    hline!([mean(mcs) 0], color = [:red :black], label=["mean" ""])
    vline!([0 mean(mcs)], color = [:black :red], label=["" "mean"])
    # vline!([0 1.0], color = [:black :green],label=["" "true mean"])
end

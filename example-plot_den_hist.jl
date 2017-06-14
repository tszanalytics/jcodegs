include("plot_den_hist.jl")

x = rand(Gamma(3,2),10000)

plot_den_hist(x,bins=200)


x = randn(10000, 1);
plot_den_hist(x)
plot_den_hist(x,bins=10)

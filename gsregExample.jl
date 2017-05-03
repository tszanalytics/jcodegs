# example of using gsreg function for Gibbs linear regression
using Distributions
using Plots
pyplot()

# generate data
srand(13457)
n = 100
trusig = 0.05
x = rand(Normal(1, 2), n)
e = rand(Normal(0, trusig), n)
y = 1.0 + 2.0*x + e
scatter([x y],palette = :blues, alpha = 0.3,legend=false,gridcolor=:grey,
             xlab = "x", ylab = "y")

# data set up for use in function
n = length(y)
X = [ones(n) x]

include("gsreg.jl")

# uninformative prior, M iterations
bs, s2s = gsreg(y,X, M = 1000)



# Informative prior, M iterations
b0 = [1.0; 1.0]  # b0 must be a column vector!
iB0 = [1.0 0.0; 0.0 1.0]
d0 = 0.1
a0 = 0.01

# tau is starting value
bs, s2s = gsreg(y,X, M = 10000,b0=b0,iB0=iB0,d0=d0,a0=a0,tau=0.1)


mean(bs[:,1])
std(bs[:,1])
mean(bs[:,2])
std(bs[:,2])
mean(s2s)
std(s2s)

using PlotRecipes
include("mcmc_sample_plot.jl")
mcmc_sample_plot(bs[:,2])
vline!([0.0 2.0], color = :green, label=["" "true mean"])  # add vertical line

mcmc_sample_plot(bs[:,1])


mcmc_sample_plot(s2s)
vline!([0.0 trusig^2], color = [:black :green], label=["" "true mean"])

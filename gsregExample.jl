# example of using gsreg function for Gibbs linear regression
using Distributions, Plots, StatPlots, LinearAlgebra, Random
Random.seed!(1235)

# generate data
n = 100
trusig = 2.0
x = rand(Normal(1, 2), n)
e = rand(Normal(0, trusig), n)
y = 1.0 .+ 2.0.*x + e

cor(y,x)
plot(x,y, st=:scatter,linecolor=:blue, alpha=0.3, gridcolor=:grey, legend=false, xlab = "x", ylab = "y")
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

include("mcmc_sample_plot.jl")
mcmc_sample_plot(bs[:,2])
vline!([0.0 2.0], color = :green, label=["" "true mean"])  # add vertical line

mcmc_sample_plot(bs[:,1])


mcmc_sample_plot(s2s)
vline!([0.0 trusig^2], color = [:black :green], label=["" "true mean"])

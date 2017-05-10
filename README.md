# jcodegs
Gibbs sampler for linear regression code.

The default prior is an uninformative normal-gamma (large prior variances).
An informative normal-gamma prior can be specified.

gsreg.jl is the gibbs sampler for linear regresion function, and produces an MCMC sample for the $k$ regression parameters and the       model variance, $\sigma^2$.
  
mcmc_sample_plot.jl is a function to produce a time plot and density plot from an MCMC sample.

gsregExample.jl is a a simple example using the above two functions.

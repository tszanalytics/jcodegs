# jcodegs
Gibbs sampler for linear regression code.

Default prior is uninformative normal-gamma (large prior variances).
User can specify an informative normal-gamma prior.

gsreg.jl is the gibbs sample for linear regresion function, and produces an MCMC sample for the $k$ regression parameters and the       model variance, $\sigma^2$.
  
mcmc_sample_plot.jl is a function to produce a time plot and density plot from an MCMC sample.

gsregExample.jl is a a simple example using the above two functions.

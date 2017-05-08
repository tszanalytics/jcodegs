# gibbs sampling for linear regression

##### Dependency: Distributions
#####  -  must call Distributions package before calling the function

# To include an intercept, X must contain ones in first column.
# model: y = Xb + e
# b0 is prior mean for b, iB0 = prior precision matrix for b (inv of cov. matrix)
# a0 and d0 are priors for precision tau ~ Gamma(a0/2, d0/2).
# M = mcmc iterations
# tau is the starting value (= 1/sigma2)

#### usage: gsreg(y,X)   # uses default uninformative prior
####        gsreg(y,X,M=m,tau=t,b0=priorb,iB0 = invpriorcovb,do=priorgammab,a0=priorgammaa)
####        Note: iB0 = prior precision matrix = inv(prior variance matrix)
####              b0 must be a column Vector

function gsreg(y,X; M=10000, burnin = Int(floor(M/10.0)),tau=1.0,iB0=0.0001,b0=0.0,d0=0.0001, a0=3.0)
    # values outside iterations
    n, k = size(X)
    a1 = a0 + n
    # default uninformative priors
    if b0 == 0.0
        b0 = zeros(k)
    end
    if iB0 == 0.0001     # coefficient mean and var.
        B0 = ones(k)*10000.0
        mB0 = diagm(B0)
        iB0 = inv(mB0)
    end

    bdraws = zeros(M,k)
    s2draws = zeros(M,1)
# Gibbs algorithm
    for i = 1:(M + burnin)

    # draw betas
        Db = inv(X'*X.*tau[1] + iB0)
        db = X'y*tau[1] + iB0*b0
        H = chol(Hermitian(Db))
        betas = Db*db + H'*randn(k,1)

    # draw sigma sq.
    #### N.B. second parameter is inverse of Greenberg/Koop defns.!
        d1 = d0 + (y-X*betas)'*(y-X*betas)
        tau = rand(Gamma(a1[1]/2,2/d1[1]),1)
        sig2 = 1/tau[1]

    # store draws
        if i > burnin
            j = i - burnin
            bdraws[j,:] = betas.'
            s2draws[j] = sig2
        end

    end
    return bdraws,s2draws
end

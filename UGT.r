#Unique Genotypes Test
#This test gives the 1 tailed P-value to test the fraction of replications where random draws of genotypes from a population are less than the observed number of genotypes (g). Use a minimum of 10,000 replications, and repeat to ensure repeatability.
#Citation: Reynolds, R.G. (2011) Islands, metapopulations, and archipelagos: genetic equilibrium and non-equilibrium dynamics of structured populations in the context of conservation. Ph.D. Dissertation, University of Tennessee. 



NG.test <- function(X,N,n,reps){
	# X is a vector of band frequencies
	# N is the diploid sample size
	# n is the observed number of unique genotypes
	L <- length(X) # determine number of markers
	G <- numeric()
	for(i in 1:reps){
		genos <- matrix(NA,N,L)
		for(j in 1:L){
			genos[,j] <- sample(c(0,1),size=N,replace=TRUE,prob=c(1-X[j],X[j]))
			}
		geno.c <- numeric()
		for(j in 1:N){
			geno.c[j] <- paste(genos[j,],sep="",collapse="")
			}
		G[i] <- length(unique(geno.c))
		}
	G
	}


#Example
#Sample Data:
#Simulate band frequencies from a beta distribution, with 29 samples and shape parameters of 0.2

X <- rbeta(29,.2,.2)
hist(X)
sum(X*(1-X)>1/29)
N <- 29
n <- 15
reps <- 10000
xx <- NG.test(X=X,N=N,n=n,reps=reps)
hist(xx)
sum(xx<n)/reps
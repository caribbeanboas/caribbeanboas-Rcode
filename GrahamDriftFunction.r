#GrahamDriftFunction
#Written by R. Graham Reynolds 2006
#www.rgrahamreynolds.info
#Citation Reynolds, RG. 2011. Genetic drift function for R. Available @ www.rgrahamreynolds.info 

grahamdriftfunction.fn<-function(n,p,t)
{
	alleles<-c(rep(1,p*n),rep(0,p*n))
	frequency<-sum(alleles)/(n)
	alleles.n<-rep(NA,(2*n))
	for(j in 1:t){
		for(i in 1:(2*n)){
			alleles.n[i]<-sample(alleles,size=1)
		}
		alleles<-alleles.n
		frequency<-c(frequency,sum(alleles)/(2*n))
	}
	plot(0:t, frequency, type="l", ylim=c(0,1),col="blue", ann=FALSE)
	lines(0:t, rep(p,(t+1)), lty=2)
	for(x in 1:(n-1)){
		alleles<-c(rep(1,p*n),rep(0,p*n))
		frequency<-sum(alleles)/(n)
		alleles.n<-rep(NA,(2*n))
		for(j in 1:t){
			for(i in 1:(2*n)){
				alleles.n[i]<-sample(alleles,size=1)
			}
			alleles<-alleles.n
			frequency<-c(frequency,sum(alleles)/(2*n))
		}
		lines(0:t, frequency, col="blue")
	}
title(ylab="Allele frequency", col.lab=rgb(0,0.5,0))
title(main="Genetic Drift Simulation", col.main="blue")
title(xlab="Generation", col.lab=rgb(0,0.5,0))

}

#n=number of replicates
#p=initial allele frequency
#t= number of generations

#Example
#grahamdriftfunction.fn(10,0.5,20)
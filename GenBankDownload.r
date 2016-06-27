#GenBankDownload
#Written by R. Graham Reynolds 2010
#www.rgrahamreynolds.info

#Error message note: If you get an error message "Error in FI[i]:LA[i] : NA/NaN argument" Try installing the latest version of R and the latest build of ape

library(ape)
#This script automatically downloads sequence data from Genbank- all you have to do is input the accession numbers
#There are two ways to input accession numbers: either list them all or use a shorthand if they are from the same series
#This example uses cytb data for Epicrates snakes from the West Indies
#List
accession<-c("U69795","U69796","U69797","U69798","U69799","U69800","U69801","U69802","U69803")

#Shorthand
#In this example there are 9 sequences from the same series, so we can avoid inputting all of the numbers individually by stating the first three alphanumeric characters common to all sequences, then listing the starting and ending numbers and using each number in that series
accession<-paste("U69", seq(795,803,1), sep="")

GenBankDownload=read.GenBank(accession,species.name=TRUE)
# read.Genbank is a function in ape
#Defines the species names for each sequence
#now attach the species names to the sequences
cbind(attr(GenBankDownload, "species"), names(GenBankDownload))
Species = c(paste(attr(GenBankDownload, "species"), names(GenBankDownload),sep=""))
GenBankDownload=read.GenBank(accession,seq.names=Species)
write.dna(GenBankDownload,file="GenBankDownload.txt",format="fasta")


#Now that we have a fasta file, we want to check some attributes of the sequences:
#Check the sequence lengths:
table(unlist(lapply(GenBankDownload, length)))
#This tells us how many sequences there are of each length
#Now we can align these sequences externally and read them back into R



##For large mixed sequence groups
# Search GenBank for the taxa + gene(s) desired
# Download the Accession List ("Send to" -> "File"->Format=Accession List->"Create File)
#Now, arrange the list for input to be read by ape:

accessions<-read.table("nuccore_result.txt")

#Now, arrange accession numbers with quotes for each number and a comma separator
cat(paste(shQuote(accessions$V1, type="cmd"),collapse=","))

#Now, write as a text file
write.table(matrix(as.character(accessions$V1),nrow=1), "data.txt",sep=",", row.names=FALSE, col.names=FALSE)

#Hint- You will probably want to remove the ".1" at the end of each accession number




#Now you are ready to proceed as above

#If you are still getting an error message, try the following manipulation
#Check data structure
str(accessions)

#reformat structure
accessions<-as.matrix(accessions)
accessions<-c(accessions)
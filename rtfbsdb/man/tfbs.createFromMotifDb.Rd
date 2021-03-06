\name{tfbs.createFromMotifDb}
\alias{tfbs.createFromMotifDb}
\title{
Create TF object by querying the MotifDb dataset.
}
\description{
Create TF object from the MotifDb object which is a annotated collection of Protein-DNA binding sequenece motifs. The subset of MotifDb can be obtained by the methods in the MotifDb package or by the criteria in this function.
}
\usage{
tfbs.createFromMotifDb(motifDB= NULL, 
      organism = "Hsapiens", 
      geneSymbol = NULL, 
      tfFamily = NULL, 
      providerName = NULL, 
      providerId = NULL, 
      dataSource = NULL, 
      geneId = NULL, 
      geneIdType = NULL, 
      proteinId = NULL, 
      proteinIdType = NULL, 
      sequenceCount = NULL, 
      bindingSequence = NULL, 
      bindingDomain = NULL, 
      experimentType = NULL, 
      pubmedID = NULL, 
      pseudocount = -7)
}
\arguments{
  \item{motifDB}{MotifDb object or subset of MotifDb. }
  \item{organism}{String, species, use command \code{ print (table (values (MotifDb)$organism)) } to check full list.}
  \item{geneSymbol}{String, gene symbol is used as Motif_ID in \code{"\linkS4class{tfbs}"}, \cr
        use command \code{ print (table (values (MotifDb)$geneSymbol)) } to check full list.}
  \item{tfFamily}{String, TF family is used as TF_Name in \code{"\linkS4class{tfbs}"}, \cr
        use command \code{ print (table (values (MotifDb)$tfFamily)) } to check full list.}
  \item{providerName}{String, use command \code{ print (table (values (MotifDb)$providerName)) } to check full list.}
  \item{providerId}{String, use command \code{ print (table (values (MotifDb)$providerId)) } to check full list.}
  \item{dataSource}{String, use command \code{ print (table (values (MotifDb)$dataSource)) } to check full list.}
  \item{geneId}{String, use command \code{ print (table (values (MotifDb)$geneId)) } to check full list.}
  \item{geneIdType}{String, use command \code{ print (table (values (MotifDb)$geneIdType)) } to check full list.}
  \item{proteinId}{String, use command \code{ print (table (values (MotifDb)$proteinId)) } to check full list.}
  \item{proteinIdType}{String, use command \code{ print (table (values (MotifDb)$proteinIdType)) } to check full list.}
  \item{sequenceCount}{String, use command \code{ print (table (values (MotifDb)$sequenceCount)) } to check full list.}
  \item{bindingSequence}{String, use command \code{ print (table (values (MotifDb)$bindingSequence)) } to check full list.}
  \item{bindingDomain}{String, use command \code{ print (table (values (MotifDb)$bindingDomain)) } to check full list.}
  \item{experimentType}{String, use command \code{ print (table (values (MotifDb)$experimentType)) } to check full list.}
  \item{pubmedID}{String, use command \code{ print (table (values (MotifDb)$pubmedID)) } to check full list.}
  \item{pseudocount}{Number, log value for zero value in PWM matrix, default is -7.}
}
\details{
Two methods to make a subset obeject.

1.Using the methods provided by the MotifDB package, please check the maunal of MotifDb package.

2. Searching the meta information and PWM matrices in the MotifDb object according to the criteria specified
by the parameters of \emph{organism}, \emph{geneSymbol}, \emph{tfFamily}, \emph{providerName}, etc.

}
\value{
A tfbs object is returned with PWM matrices, see Also as \code{"\linkS4class{tfbs}"}
}

\references{
The MotifDB is in Bioconductor. 
\url{http://bioconductor.org/packages/release/bioc/html/MotifDb.html}
}

\author{
MotifDB is authored by Paul Shannon.
}
\seealso{
See Also as \code{"\linkS4class{tfbs}"}
}
\examples{

library(rtfbsdb);

if( require(MotifDb) )
{
	# Load the subset of MotifDb generated by the method in 'MotifDb' package
	mdb.sox4 <- query (MotifDb,'sox4');
	tfs0 <- tfbs.createFromMotifDb(mdb.sox4, organism=NULL);

	# Load the subset of MotifDb generated by the method in 'MotifDb' package
	mdb.human <- query(MotifDb, 'hsapiens');
	tfs1 <- tfbs.createFromMotifDb(mdb.human, organism=NULL); 
}

# Load all motifs.
tfs2 <- tfbs.createFromMotifDb(organism=NULL); 

show(MotifDb);

head(unique(tfs2@tf_info$organism), n=30);
head(unique(tfs2@tf_info$tfFamily), n=30);
head(unique(tfs2@tf_info$dataSource), n=30);
head(unique(tfs2@tf_info$experimentType), n=30);
head(unique(tfs2@tf_info$geneIdType), n=30);
head(unique(tfs2@tf_info$bindingDomain), n=30);

# Load all motifs of mouse species.
tfs4 <- tfbs.createFromMotifDb(organism="Mmusculus"); 

# Default: Load all motifs of human species.
tfs5 <- tfbs.createFromMotifDb(); 

# Load all motifs of Drosophila.melanogaster species.
tfs.Drosophila.melanogaster <- tfbs.createFromMotifDb(organism="Dmelanogaster"); 

# TFBS scanning
tfs.ap2 <- tfbs.createFromMotifDb(organism = "Hsapiens", tfFamily="AP2"); 

gen.bed <- data.frame(chr="chr19", 
      start=round(runif(10,1000000, 2000000)), 
      stop=0, 
      name="", 
      score=0, 
      strand=".");
gen.bed$stop <- gen.bed$start + 3000;

file.twoBit <- system.file("extdata","hg19.chr19.2bit", package="rtfbsdb")

t1 <- tfbs.scanTFsite( tfs.ap2, 
      file.twoBit, 
      gen.bed, 
      file.prefix="test.db",
      ncores = 1);

}
\keyword{ MotifDb }
\keyword{ tfbs object }

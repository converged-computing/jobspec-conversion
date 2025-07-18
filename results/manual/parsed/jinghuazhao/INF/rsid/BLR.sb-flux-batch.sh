#!/bin/bash
#FLUX: --job-name=_BLR
#FLUX: --queue=cardio
#FLUX: -t=86400
#FLUX: --urgency=16

export protein___uniprot='$(cut -d ' ' -f1-28 --complement ${INF}/h2/s.sample | head -1 | tr ' ' '\n' | grep -v BDNF | awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]')'

export protein___uniprot=$(cut -d ' ' -f1-28 --complement ${INF}/h2/s.sample | head -1 | tr ' ' '\n' | grep -v BDNF | awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]')
Rscript -e '
meyer_test <- function()
{
  set.seed(1234567)
  meyer <- within(meyer,
           {
             yNa <- y
              g1 <- ifelse(generation == 1, 1, 0)
              g2 <- ifelse(generation == 2, 1, 0)
              id <- animal
          animal <- ifelse(!is.na(animal), animal, 0)
             dam <- ifelse(!is.na(dam), dam, 0)
            sire <- ifelse(!is.na(sire), sire, 0)
           })
  G <- kin.morgan(meyer)$kin.matrix * 2
  r <- regress(y ~ -1 + g1 + g2, ~ G, data = meyer)
  r
  attach(meyer)
  X <- as.matrix(meyer[c("g1", "g2")])
  m <- BLR(yNa, XF = X, GF = list(ID = 1:nrow(G), A = G),
           prior = list(varE = list(df = 1, S = 0.25),
           varU = list(df = 1, S = 0.63)),
           nIter = 5000, burnIn = 500, thin = 1, saveAt = "meyer.BLR_")
  with(r, h2G(sigma, sigma.cov))
}
scallop <- function(protein,reml=FALSE,eps=0.02)
{
  if (reml)
  {
    m <- as.formula(paste(protein,"~",paste(covar,collapse="+"),"+",paste(qcovar,collapse="+"),"+","GRM"))
    i <- regress(m, data = s)
    print(i)
  }
  attach(s)
  X <- as.matrix(s[c(covar, qcovar)])
  keep <- !is.na(apply(X,1,sum))
  y <- s[[protein]][keep]
  XF <- X[keep,]
  A <- with(G,GRM)[keep,keep] + eps*diag(length(keep[keep]))
  m <- BLR(y, XF = XF, GF = list(ID = 1:nrow(A), A = A),
           prior = list(varE = list(df = 1, S = 0.25),
           varU = list(df = 1, S = 0.63)),
           nIter = 250000, burnIn = 10000, thin = 1, saveAt = paste0(protein,".BLR_"))
  with(m, h2G(sigma, sigma.cov))
  detach(s)
  attach(m)
  varU
  varE
  varU / ((1 + eps) * varU + varE)
  U <- as.mcmc(scan(paste0(protein,".BLR_varU.dat"))[-(1:10000)])
  E <- as.mcmc(scan(paste0(protein,".BLR_varE.dat"))[-(1:10000)])
  e <- as.mcmc(cbind(U, E, h2 = U / ((1 + eps) * U + E)))
  summary(e)$statistics
  HPDinterval(e)
  pdf(paste0(protein,".BLR.pdf"))
  plot(e)
  dev.off()
}
library("regress")
library("BLR")
library("coda")
library(gap)
INF <- Sys.getenv("INF")
setwd(file.path(INF,"h2","BLR"))
s <- read.table("s.sample",check.names=FALSE,header=TRUE)
covar <- c("sexPulse","season","plate")
qcovar <- c("age","bleed_to_process_time",paste0("PC",1:20))
prefix <- file.path(INF,"h2","INTERVAL")
G <- ReadGRMBin(prefix)
GRM <- with(G,GRM)
protein___uniprot <- Sys.getenv("protein___uniprot")
scallop(protein___uniprot)
'

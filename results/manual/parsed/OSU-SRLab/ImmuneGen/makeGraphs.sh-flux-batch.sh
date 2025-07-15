#!/bin/bash
#FLUX: --job-name=confused-banana-1828
#FLUX: -N=5
#FLUX: -t=345600
#FLUX: --urgency=16

reg=`echo $1`
name=`echo $2`
user=`echo $3`
module load R/4.1.0-gnu9.1
cd /fs/ess/PAS0854/Active_projects/SV_SNV_CompBatch/makeGraphs
Rscript assignFunction.R `echo $name`

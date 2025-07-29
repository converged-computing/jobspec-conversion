#!/bin/bash
#SBATCH --account=PAS0854
#SBATCH --nodes=5
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-00:00:00

reg=`echo $1`
name=`echo $2`
user=`echo $3`
module load R/4.1.0-gnu9.1
cd /fs/ess/PAS0854/Active_projects/SV_SNV_CompBatch/makeGraphs
Rscript assignFunction.R `echo $name`

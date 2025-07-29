#!/bin/bash
#SBATCH --mail-user=james.junker1@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00

pwd
echo "This is the R-batch-job running bayesian models of stream metabolism"
Rscript code/remote-met-run.R data/HOPB.rds

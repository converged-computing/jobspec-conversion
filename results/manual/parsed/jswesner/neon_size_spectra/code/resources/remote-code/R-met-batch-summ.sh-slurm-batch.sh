#!/bin/bash
#SBATCH --mail-user=james.junker1@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

pwd
echo "This is the R-batch-job running bayesian models of stream metabolism"
Rscript code/remote-met-mm-summ.R output/models/REDB_mm.rds
echo "Script finished"

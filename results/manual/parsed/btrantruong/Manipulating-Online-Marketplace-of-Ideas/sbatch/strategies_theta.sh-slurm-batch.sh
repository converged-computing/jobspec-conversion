#!/bin/bash
#SBATCH --job-name=strategy_theta
#SBATCH --mail-user=baotruon@iu.edu
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=3-23:59:00
#SBATCH --constraint=ntasks-per-node=1

source /N/u/baotruon/Carbonate/miniconda3/etc/profile.d/conda.sh
conda activate graph
cd /N/u/baotruon/Carbonate/marketplace
echo '###### compare strategies vary theta ######'
snakemake --snakefile workflow/rules/strategies_theta.smk --cores 20

#!/bin/bash
#SBATCH --job-name=gamma
#SBATCH --mail-user=baotruon@iu.edu
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=25
#SBATCH --time=3-23:59:00
#SBATCH --constraint=ntasks-per-node=1

source /N/u/baotruon/Carbonate/miniconda3/etc/profile.d/conda.sh
conda activate graph
cd /N/u/baotruon/Carbonate/marketplace
echo '###### compare strategies vary gamma ######'
snakemake --nolock --snakefile workflow/rules/strategies_gamma.smk --cores 25

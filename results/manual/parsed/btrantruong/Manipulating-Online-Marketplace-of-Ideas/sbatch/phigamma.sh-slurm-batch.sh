#!/bin/bash
#SBATCH --job-name=phigamma
#SBATCH --mail-user=baotruon@iu.edu
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=45
#SBATCH --time=3-23:59:00
#SBATCH --constraint=ntasks-per-node=1

source /N/u/baotruon/Carbonate/miniconda3/etc/profile.d/conda.sh
conda activate graph
cd /N/u/baotruon/Carbonate/marketplace
echo '###### vary phigamma ######'
snakemake --nolock --snakefile workflow/rules/phigamma.smk --cores 45

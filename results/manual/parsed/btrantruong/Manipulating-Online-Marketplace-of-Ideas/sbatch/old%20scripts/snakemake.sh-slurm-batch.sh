#!/bin/bash
#SBATCH --job-name=marketplacesnakemake
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
echo '###### compare strategies vary thetaphi ######'
snakemake --nolock --rerun-incomplete --snakefile workflow/rules/compare_strategies.smk --cores 20
echo '###### vary theta phi ######'
snakemake --nolock --rerun-incomplete --snakefile workflow/rules/vary_thetaphi.smk --cores 20
echo '###### vary theta gamma ######'
snakemake --nolock --rerun-incomplete --snakefile workflow/rules/vary_thetagamma.smk --cores 20
echo '###### vary phi gamma ######'
snakemake --nolock --rerun-incomplete --snakefile workflow/rules/vary_phigamma.smk --cores 20
echo '###### vary beta gamma ######'
snakemake --nolock --rerun-incomplete --snakefile workflow/rules/vary_betagamma.smk --cores 20

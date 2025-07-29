#!/bin/bash
#SBATCH --job-name=mu_fzl5
#SBATCH --account=r00382
#SBATCH --mail-user=baotruon@iu.edu
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=43
#SBATCH --mem=58gb
#SBATCH --time=3-23:59:00
#SBATCH --constraint=ntasks-per-node=1

source /N/u/baotruon/BigRed200/conda/etc/profile.d/conda.sh
conda activate simsommodel
cd /N/u/baotruon/BigRed200/simsom
echo '###### running mu_fzl5 exps ######'
snakemake --nolock --rerun-triggers mtime --rerun-incomplete --snakefile workflow/rules_zl5/vary_mu.smk --cores 43

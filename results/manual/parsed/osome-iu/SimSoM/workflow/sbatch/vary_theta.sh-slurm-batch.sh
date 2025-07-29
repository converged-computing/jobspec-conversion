#!/bin/bash
#SBATCH --job-name=fzl5_theta
#SBATCH --account=r00382
#SBATCH --mail-user=baotruon@iu.edu
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=57
#SBATCH --mem=58gb
#SBATCH --time=3-23:59:00
#SBATCH --constraint=ntasks-per-node=1

source /N/u/baotruon/BigRed200/conda/etc/profile.d/conda.sh
conda activate simsommodel
cd /N/u/baotruon/BigRed200/simsom
echo '###### running fzl5_theta exps ######'
snakemake --nolock --rerun-triggers mtime --rerun-incomplete --snakefile workflow/rules_zl5/vary_theta.smk --cores 57

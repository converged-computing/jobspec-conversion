#!/bin/bash
#SBATCH --output=/hpcfs/users/a1680844/20131906_HickeyT_JC_NormalBreast/%x_%j.out
#SBATCH --error=/hpcfs/users/a1680844/20131906_HickeyT_JC_NormalBreast/%x_%j.err
#SBATCH --mail-user=wenjun.liu@adelaide.edu.au
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=256GB
#SBATCH --time=2-00:00:00
#SBATCH --partition=batch

CORES=32
PROJ= /hpcfs/users/a1680844/20131906_HickeyT_JC_NormalBreast
source activate Snakemake
cd /hpcfs/users/a1680844/20131906_HickeyT_JC_NormalBreast
snakemake \
  --cores ${CORES} \
  --use-conda \
  --notemp \
  --wrapper-prefix 'https://raw.githubusercontent.com/snakemake/snakemake-wrappers/'
bash /hpcfs/users/a1680844/20131906_HickeyT_JC_NormalBreast/scripts/update_git.sh

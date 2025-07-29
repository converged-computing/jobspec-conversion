#!/bin/bash
#SBATCH --job-name=LDmap
#SBATCH --mail-user=thomas.brazier@univ-rennes.fr
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=400GB
#SBATCH --time=8-12:00:00

export OMP_NUM_THREADS='$ncores'

. /local/env/envsnakemake-6.0.5.sh
. /local/env/envsingularity-3.8.5.sh
. /local/env/envconda.sh
dataset=${1}
chrom=${2}
ncores=16
export OMP_NUM_THREADS=$ncores
echo "Run pipeline"
snakemake -s workflow/Snakefile -p -j $ncores --configfile data/${dataset}/config.yaml --use-conda --nolock --rerun-incomplete --printshellcmds --until k_statistics --config dataset=${dataset} chrom=${chrom} cores=$ncores

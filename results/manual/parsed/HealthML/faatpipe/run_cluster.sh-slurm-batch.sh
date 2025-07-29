#!/bin/bash
#SBATCH --job-name=controljob_%j
#SBATCH --output=snakemake_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=2-00:00:00
#SBATCH --partition=vcpu

eval "$(conda shell.bash hook)"
snakemake_env="install/snakemake"
if [ ! -d $snakemake_env ]; then
    ./install.sh
fi
conda activate snakemake
snakemake --snakefile Snakefile \
          --configfile conf/config.yaml \
	  --profile ./slurm \
          --directory "${PWD}" \
	  "${@}"

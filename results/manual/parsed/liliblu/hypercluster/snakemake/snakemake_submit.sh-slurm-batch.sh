#!/bin/bash
#SBATCH --job-name=snakeautocluster
#SBATCH --output=logs/sbatchSnakefile_progress_out.log
#SBATCH --error=logs/sbatchSnakefile_progress_err.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=27-23:59:59
#SBATCH --partition=cpu_long

module purge
module add slurm
source activate hypercluster
cd /gpfs/home/lmb529/ruggleslabHome/hypercluster
mkdir -p logs/slurm/
snakemake -j 999 -p --verbose \
-s hypercluster.smk \
--keep-going \
--cluster-config cluster.json \
--cluster "sbatch --mem={cluster.mem} -t {cluster.time} -o {cluster.output} -p {cluster.partition}"

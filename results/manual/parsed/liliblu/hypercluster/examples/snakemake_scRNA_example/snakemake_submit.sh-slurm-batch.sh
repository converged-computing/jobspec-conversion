#!/bin/bash
#SBATCH --job-name=snakeautocluster
#SBATCH --output=logs/sbatchSnakefile_progress_out.log
#SBATCH --error=logs/sbatchSnakefile_progress_err.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=27-23:59:59

module purge
module add slurm
source activate hc_test
cd /gpfs/data/ruggleslab/home/lmb529/hypercluster/examples/snakemake_scRNA_example
mkdir -p logs/slurm/
snakemake -j 999 -p --verbose \
-s ../../snakemake/hypercluster.smk \
--configfile config.yml \
--keep-going \
--cluster-config cluster.json \
--cluster "sbatch --mem={cluster.mem} -t {cluster.time} -o {cluster.output} -p {cluster.partition}"

#!/bin/bash
#FLUX: --job-name=run_snakemake
#FLUX: -t=2592000
#FLUX: --priority=16

module load snakemake/7.32.4-3.12.1
module load conda
snakemake --snakefile $1 --cluster "sbatch --mem {resources.mem_mb}\
                                                  --cpus-per-task {threads}\
                                                  --time={resources.time}\
                                                  --output=log/slurm_{rule}-%A.out\
                                                  --error=log/slurm_{rule}-%A.err"\
                                --jobs 20\
				--use-conda
                               # --keep-going #-R diamond_search

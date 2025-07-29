#!/bin/bash
#SBATCH --account=park
#SBATCH --output=logs/%j_munge-pipeline.log
#SBATCH --error=logs/%j_munge-pipeline.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:12:00

module load conda2 gcc slurm-drmaa R
source "$HOME/.bashrc"
conda activate speclet_smk
SNAKEFILE="munge/munge.smk"
snakemake \
    --snakefile $SNAKEFILE \
    --jobs 9997 \
    --restart-times 0 \
    --keep-going \
    --latency-wait 120 \
    --rerun-incomplete \
    --printshellcmds \
    --drmaa " --account=park -c {cluster.cores} -p {cluster.partition} --mem={cluster.mem} -t {cluster.time} -o {cluster.out} -e {cluster.err} -J {cluster.J}" \
    --cluster-config munge/munge-config.json
conda deactivate
exit 44

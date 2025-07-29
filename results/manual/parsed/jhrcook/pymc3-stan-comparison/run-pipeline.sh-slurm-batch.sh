#!/bin/bash
#SBATCH --account=park
#SBATCH --output=logs/%j_pipeline.log
#SBATCH --error=logs/%j_pipeline.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=2-00:00:00

module unload python
module load gcc conda2 slurm-drmaa/1.1.3
source "$HOME/.bashrc"
conda activate ppl-comp-smk
snakemake \
    --jobs 9990 \
    --restart-times 0 \
    --latency-wait 120 \
    --use-conda \
    --keep-going \
    --printshellcmds \
    --drmaa " -c {cluster.cores} -p {cluster.partition} --mem={cluster.mem} -t {cluster.time} -o {cluster.out} -e {cluster.err} -J {cluster.J}" \
    --cluster-config "pipeline_config.yaml"
conda deactivate
exit 44

#!/bin/bash
#SBATCH --job-name=demux
#SBATCH --output=/data/gpfs-1/users/cofu10_c/scratch/klara/slurm_logs/demux-%x.%j.out
#SBATCH --error=/data/gpfs-1/users/cofu10_c/scratch/klara/slurm_logs/demux-%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000M
#SBATCH --time=20:00:00

echo 'Start'
snakemake \
    -r \
    --nt \
    --jobs 20 \
    --keep-going \
    --latency-wait 180 \
    --restart-times 0 \
    --profile=cubi-v1 \
    --cluster-config=/data/gpfs-1/users/cofu10_c/work/pipelines/umi-processing/config/cluster_config.yaml \
    --use-conda -p --rerun-incomplete --conda-prefix=/data/gpfs-1/users/cofu10_c/scratch/P3473/envs
echo 'Finished'
    #--dry-run \
    # --restart-times 2 \
    # --reason \

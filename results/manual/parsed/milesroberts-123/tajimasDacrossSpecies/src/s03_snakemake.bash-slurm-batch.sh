#!/bin/bash
#SBATCH --account=josephsnodes
#SBATCH --mail-user=robe1195@msu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=7-00:00:00
#SBATCH --partition=josephsnodes
#SBATCH --constraint=ntasks-per-node=1

export XDG_CACHE_HOME='/mnt/scratch/robe1195/cache'

echo "This job is running on $HOSTNAME on `date`"
echo Loading snakemake...
conda activate snakemake
echo Changing cache directory...
export XDG_CACHE_HOME="/mnt/scratch/robe1195/cache"
echo $XDG_CACHE_HOME
echo Changing directory...
cd ../workflow
echo Unlocking snakemake...
snakemake --unlock --cores 1
echo Running snakemake...
snakemake --cluster "sbatch --time={resources.time} --partition=josephsnodes --account=josephsnodes --cpus-per-task={threads} --mem-per-cpu={resources.mem_mb_per_cpu}" --jobs 3 --cores 3 --use-conda --rerun-incomplete --rerun-triggers mtime --retries 2 --keep-going --resources load=3 --scheduler greedy --cluster-cancel "scancel" --default-resources time=10080

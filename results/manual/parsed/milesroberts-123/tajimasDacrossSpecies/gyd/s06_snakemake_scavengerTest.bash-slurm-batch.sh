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

echo "This job is running on $HOSTNAME on `date`"
echo Loading snakemake...
conda activate snakemake
echo Changing directory...
cd ../workflow
echo Unlocking snakemake...
snakemake --unlock --cores 1
echo Running snakemake...
snakemake --cluster "sbatch --time 7-00:00:00 --qos=scavenger --partition=josephsnodes --account=josephsnodes --cpus-per-task={threads} --mem-per-cpu={resources.mem_mb_per_cpu}" --jobs 990 --cores 1024 --use-conda --retries 5 --rerun-incomplete --rerun-triggers mtime

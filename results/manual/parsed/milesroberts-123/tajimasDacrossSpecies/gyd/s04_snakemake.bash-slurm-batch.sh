#!/bin/bash
#SBATCH --account=josephsnodes
#SBATCH --mail-user=robe1195@msu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=7-00:00:00
#SBATCH --partition=josephsnodes
#SBATCH --constraint=ntasks-per-node=1

echo "This job is running on $HOSTNAME on `date`"
echo Loading snakemake...
ml -* iccifort/2020.1.217 impi/2019.7.217 snakemake/5.26.1-Python-3.8.2
echo Changing directory...
cd ../workflow
echo Unlocking snakemake...
snakemake --unlock --cores 1
echo Running snakemake...
snakemake --cluster "sbatch --time 7-00:00:00 --partition=josephsnodes --account=josephsnodes --cpus-per-task={threads} --mem-per-cpu={resources.mem_mb_per_cpu}" --jobs 900 --cores 900 --use-envmodules --rerun-incomplete -T 3

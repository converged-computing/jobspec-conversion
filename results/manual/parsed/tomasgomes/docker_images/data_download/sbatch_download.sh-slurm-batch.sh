#!/bin/bash
#SBATCH --job-name=download_data
#SBATCH --output=outfile.txt
#SBATCH --error=errfile.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=32G
#SBATCH --time=06:00:00
#SBATCH --nodelist=compute-21

singularity run --mount type=bind,src=$(pwd),dst=/rootvol /mnt/beegfs/singularity/images/data_download_nextflow.sif run nf-core/fetchngs --max_memory 31GB --max_cpus 6 --input /rootvol/ids.csv --outdir /rootvol/

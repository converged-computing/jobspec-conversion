#!/bin/bash
#SBATCH --job-name=test_wrapper
#SBATCH --output=outfile.txt
#SBATCH --error=errfile.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100M
#SBATCH --time=00:01:30
#SBATCH --nodelist=compute-1

singularity run --mount type=bind,src=$(pwd),dst=/rootvol \
        /mnt/beegfs/singularity/images/nextflow_kallisto_sc.sif run \
        /rootvol/kallisto_pipeline.nf

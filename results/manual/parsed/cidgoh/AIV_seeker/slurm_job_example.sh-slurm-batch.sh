#!/bin/bash
#SBATCH --job-name=aiv_seeker
#SBATCH --account=rrg-whsiao-ab
#SBATCH --output=/scratch/djhyq557/aiv_sim/logs/%j.out
#SBATCH --error=/scratch/djhyq557/aiv_sim/logs/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8g
#SBATCH --time=06:00:00

 module load nextflow/22.04.3
 nextflow run main.nf --input /scratch/djhyq557/test_aiv/AIV_seeker/demo_data/samplesheet.csv -profile singularity,slurm

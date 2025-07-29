#!/bin/bash
#SBATCH --job-name=ref_h3a_mis
#SBATCH --mail-user=mbymam001@myuct.ac.za
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=7000
#SBATCH --time=10-00:00:00
#SBATCH --partition=Main

cd /cbio/users/mamana/refimpute
nextflow \
    ~/refimpute/process_ref_h3a_mis.nf \
    -c /cbio/projects/001/clients/refimpute/process_ref_h3a_mis_v4.config \
    -profile singularity,slurm \
    -resume

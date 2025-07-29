#!/bin/bash
#SBATCH --output=/projects/ovcare/classification/pouya/Irem/ocr_dov_1.out
#SBATCH --error=/projects/ovcare/classification/pouya/Irem/ocr_dov_1.err
#SBATCH --mail-user=pouya.ahmadvand@gmail.com
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=150G
#SBATCH --time=7-18:00:00
#SBATCH --chdir=/projects/ovcare/classification/singularity_modules/singularity_ocr

singularity run --bind /projects:/projects singularity_ocr.sif -d \
"/projects/ovcare/classification/pouya/Irem/globus_mount" -o \
/projects/ovcare/classification/pouya/Irem/DOV/Results_batch_1 -l \
/projects/ovcare/classification/pouya/Irem/DOV/Label_batch_1 \
--num_workers 100

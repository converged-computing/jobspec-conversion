#!/bin/bash
#SBATCH --job-name=mqc
#SBATCH --account=phillipslab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --array=0

module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 MultiQC/1.3-Python-2.7.13
cd /projects/phillipslab/ateterina/CR_map/FINAL/data/fastqc_raw
multiqc .

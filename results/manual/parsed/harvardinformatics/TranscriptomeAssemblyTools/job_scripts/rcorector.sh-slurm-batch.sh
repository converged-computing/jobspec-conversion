#!/bin/bash
#SBATCH --job-name=rcorrector
#SBATCH --output=rcorrector.%A.out
#SBATCH --error=rcorrector.%A.err
#SBATCH --mail-user=<PUT
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=48000
#SBATCH --time=23:00:00

"""
For this script to initialize a conda environment, a version of python that supports
anaconda or mamba will need to be in PATH. In a case where the HPC environment has python
available as a loadable module, such as the Harvard Cannon cluster, 
it will simply require adding: module load python.
"""
source activate rcorrector
"""
R1 and R2 are the first and second command line arguments that follow "sbatch rcorrector.sh
R1 is a comma-separated list of the left (R1) fastq files, and R2 is a similar list for the right (R2) reads
"""
R1=$1
R2=$2
run_rcorrector.pl -t 16 -1 $R1 -2 $R2

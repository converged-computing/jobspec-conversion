#!/bin/bash
#SBATCH --account=niwa00013
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=200G
#SBATCH --time=1-00:00:00

module load Mule
/opt/nesi/CS500_centos7_skl/Anaconda2/2019.10-GCC-7.1.0/bin/python batch-u-be509.py

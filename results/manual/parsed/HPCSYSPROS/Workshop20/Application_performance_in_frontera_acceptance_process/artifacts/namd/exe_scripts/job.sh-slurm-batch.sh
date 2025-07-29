#!/bin/bash
#SBATCH --job-name=namd
#SBATCH --account=A-ccsc
#SBATCH --nodes=1600
#SBATCH --ntasks=76800
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=test2

module load intel/16.0.3
ibrun /work/00410/huang/namd/build/2.12_skx/NAMD_2.12_Source/Linux-KNL-icc/namd2 chromat100-bench.namd &> log

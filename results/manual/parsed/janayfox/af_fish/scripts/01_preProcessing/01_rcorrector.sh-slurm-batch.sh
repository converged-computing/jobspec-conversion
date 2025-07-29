#!/bin/bash
#SBATCH --account=def-barrett
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=4G
#SBATCH --time=5-00:00:00

module load rcorrector
perl /cvmfs/soft.computecanada.ca/easybuild/software/2020/avx512/Core/rcorrector/1.0.4/bin/run_rcorrector.pl -t 12 -1 $1 -2 $2 -od /home/janayfox/scratch/afFishRNA/rcorrector_output

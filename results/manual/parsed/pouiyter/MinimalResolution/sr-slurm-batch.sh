#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=out1
#SBATCH --error=err1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=127
#SBATCH --nodelist=node1

./mr_st 35 36
./BPtab 35
./mr_BP 35 35

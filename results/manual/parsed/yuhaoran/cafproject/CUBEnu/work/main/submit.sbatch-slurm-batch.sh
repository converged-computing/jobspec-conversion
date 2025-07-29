#!/bin/bash
#SBATCH --job-name=test_main2
#SBATCH --output=output_main.txt
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=80
#SBATCH --time=00:25:00
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='80'
export FOR_COARRAY_NUM_IMAGES='8'

cd $SLURM_SUBMIT_DIR
source ../utilities/module_load_niagara_intel.sh
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export FOR_COARRAY_NUM_IMAGES=8
export OMP_NUM_THREADS=80
cd ../main/
./main.x

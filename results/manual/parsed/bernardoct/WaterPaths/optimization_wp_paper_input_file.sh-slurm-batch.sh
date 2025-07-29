#!/bin/bash
#SBATCH --job-name=borg_input_file
#SBATCH --output=output/borg_input_file.out
#SBATCH --error=error/borg_input_file.err
#SBATCH --mail-user=bct52@cornell.edu
#SBATCH --mail-type=all
#SBATCH --nodes=16
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=5-20:00:00
#SBATCH: --exclusive

export OMP_NUM_THREADS='5'

export OMP_NUM_THREADS=5
cd $SLURM_SUBMIT_DIR
module load valgrind/3.15.0
mpirun -np 48 ./waterpaths -I Tests/test_input_file_borg.wp

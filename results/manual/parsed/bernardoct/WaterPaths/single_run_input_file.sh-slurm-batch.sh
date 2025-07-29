#!/bin/bash
#SBATCH --job-name=test_wp_input_file
#SBATCH --output=output/test_wp_input_file.out
#SBATCH --error=error/test_wp_input_file.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:30:00
#SBATCH --exclusive

export OMP_NUM_THREADS='16'

export OMP_NUM_THREADS=16
cd $SLURM_SUBMIT_DIR
./waterpaths -I Tests/test_input_file_dv_file.wp

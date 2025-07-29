#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --account=pdc.staff
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

ml rocm/5.0.2                # Load a ROCm module
ml craype-accel-amd-gfx90a   # set the accelerator target
srun ./ex04.x > output.txt  # Run the ex04.x executable named myexe and write the output into output.txt

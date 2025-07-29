#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=skylake-gold
#SBATCH --qos=long
#SBATCH --nodelist=cn61[4-7]

echo ${SLURM_JOB_NODELIST}
module unload
module load gcc/7.3.0 cmake openmpi/3.1.3-gcc_7.3.0 likwid
srun -w ${SLURM_JOB_NODELIST} -n 4 hostname

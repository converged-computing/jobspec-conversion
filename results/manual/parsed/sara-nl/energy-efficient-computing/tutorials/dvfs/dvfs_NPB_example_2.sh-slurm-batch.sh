#!/bin/bash
#SBATCH --job-name=NPB_dvfs
#SBATCH --output=NPB_dfvs.%j.out
#SBATCH --error=NPB_dfvs.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:55:00
#SBATCH --exclusive

module load 2023
module load foss/2023a
for frequency in {1500000..2600000..100000} #AMD (Rome) EPYC 7H12 64-Core Processor
do
    echo "Launching NPB @ Freq=$frequency"
    srun --ear-cpufreq=$frequency --ear-policy=monitoring --ear-verbose=1 --ntasks=128  /projects/0/energy-course/NPB3.4-MZ-MPI/sp-mz.D.x
done

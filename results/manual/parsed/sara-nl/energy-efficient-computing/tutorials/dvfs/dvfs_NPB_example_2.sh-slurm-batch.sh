#!/bin/bash
#FLUX: --job-name=NPB_dvfs
#FLUX: --exclusive
#FLUX: --queue=rome
#FLUX: -t=3300
#FLUX: --urgency=16

module load 2023
module load foss/2023a
for frequency in {1500000..2600000..100000} #AMD (Rome) EPYC 7H12 64-Core Processor
do
    echo "Launching NPB @ Freq=$frequency"
    srun --ear-cpufreq=$frequency --ear-policy=monitoring --ear-verbose=1 --ntasks=128  /projects/0/energy-course/NPB3.4-MZ-MPI/sp-mz.D.x
done

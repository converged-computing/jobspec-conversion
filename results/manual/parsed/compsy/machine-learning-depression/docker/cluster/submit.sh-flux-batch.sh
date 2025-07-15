#!/bin/bash
#FLUX: --job-name=python_cpu
#FLUX: -N=30
#FLUX: -c=23
#FLUX: -t=7200
#FLUX: --urgency=16

export MPLBACKEND='agg'
export OMP_NUM_THREADS='23'

module load Python/3.5.1-foss-2016a
module load R/3.3.1-foss-2016a
module load OpenMPI/1.10.2-GCC-4.9.3-2.25
gitdir="ICPE_machine_learning_workgroup"
cd $gitdir
echo "Running main.py"
export MPLBACKEND="agg"
export OMP_NUM_THREADS=23
srun python3 main.py -c -n -f
echo "Finished main.py"

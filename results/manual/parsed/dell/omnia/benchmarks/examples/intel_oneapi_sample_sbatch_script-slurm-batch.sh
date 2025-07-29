#!/bin/bash
#SBATCH --job-name=testONEAPI
#SBATCH --output=output.txt
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=normal
#SBATCH --nodelist=springnode00003.spring.test,springnode00004.spring.test

export FI_PROVIDER='tcp'

pwd; hostname; date
export FI_PROVIDER=tcp
source /opt/intel/oneapi/setvars.sh
cd /home/omnia-share/mp_linpack
srun -N 2 --mpi=pmix -n 2 xhpl_intel64_dynamic
date

#!/bin/bash
#FLUX: --job-name=run-gromacs
#FLUX: -t=259200
#FLUX: --priority=16

cd /scratch/work/courses/CHEM-GA-2671-2022fa/yw5806/comp-lab-class/Inputs/ParallelTemp
module purge
module load gromacs/openmpi/intel/2018.3
mpirun -np 4 gmx_mpi mdrun -s adp -multidir T300/ T350 T400/ T450 -deffnm adp_exchange4temps -replex 50

#!/bin/bash
#FLUX: --job-name=name
#FLUX: -c=2
#FLUX: --queue=s.phys
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MPI_NUM_RANKS='$SLURM_NTASKS_PER_NODE'
export OMP_PLACES='cores  ## with enabled hyperthreading this line needs to be commented out'

module load intel/19.1.3
module load impi/2019.9
module load cuda/11.4
module load gromacs/2019.6
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MPI_NUM_RANKS=$SLURM_NTASKS_PER_NODE
export OMP_PLACES=cores  ## with enabled hyperthreading this line needs to be commented out
sys=$1
srun gmx_mpi mdrun -v -pin on  -noappend -ntomp $OMP_NUM_THREADS -maxh 23.9 -deffnm $sys"_prod" -cpi $sys"_prod_prev.cpt" -replex 500 -multidir 278.00 283.54 289.17 294.90 300.72 306.63 312.64 318.75 324.95 331.26 337.67 344.18 350.79 357.52 364.35 371.29 378.35 385.51 392.80 400.22 407.75 415.40 423.17 431.08

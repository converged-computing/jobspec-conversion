#!/bin/bash
#FLUX: --job-name=DoubNP
#FLUX: -N=12
#FLUX: -n=1152
#FLUX: -t=43200
#FLUX: --urgency=16

export SLURM_CPU_BIND='none'
export SLURM_CPUS_PER_TASK='$THREADS'
export OMP_NUM_THREADS='$THREADS'
export GMX_MAXCONSTRWARN='-1'

echo $(date)
echo -e "================================================================================\n"
THREADS=2
export SLURM_CPU_BIND=none
export SLURM_CPUS_PER_TASK=$THREADS
export OMP_NUM_THREADS=$THREADS
export GMX_MAXCONSTRWARN=-1
module load intel/19.1.3
module load impi/2019.9
module load gromacs/2021.2-plumed
STYLE=npt
if [ -f $TPRFILE ]; then
     srun --cpus-per-task=$SLURM_CPUS_PER_TASK \
          gmx_mpi mdrun -v -s $STYLE \
                        -o $STYLE \
                        -e $STYLE \
                        -x $STYLE \
                        -c $STYLE \
                        -cpo $STYLE \
                        -cpi $STYLE.cpt \
                        -ntomp $THREADS \
                        -dlb yes \
                        -pin on
fi

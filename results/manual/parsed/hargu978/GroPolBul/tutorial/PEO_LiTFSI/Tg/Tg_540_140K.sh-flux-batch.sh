#!/bin/bash
#FLUX: --job-name=crusty-muffin-3414
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ml PDC
ml gromacs
rm \#* core
for conc in 0.02;do
srun gmx_mpi mdrun -s npt_${conc}.tpr -cpi npt_${conc}.cpt -deffnm npt_${conc} -v #-nsteps 130000
done
rm \#*

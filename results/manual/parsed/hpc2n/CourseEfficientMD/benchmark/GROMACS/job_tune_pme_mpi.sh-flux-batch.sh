#!/bin/bash
#FLUX: --job-name=bricky-animal-1836
#FLUX: -n=4
#FLUX: -c=7
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

ml purge
ml GCC/8.2.0-2.31.1  CUDA/10.1.105  OpenMPI/3.1.3
ml GROMACS/2019.2
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    mdargs="-ntomp $SLURM_CPUS_PER_TASK"
else
    mdargs="-ntomp 1"
fi
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
rm -f bencherr* bench.edr bench.log* ion_channel_bench* perf.out
gmx grompp -f step4.1_equilibration.mdp -o step4.1_equilibration.tpr -c step4.0_minimization.gro -r step3_charmm2gmx.pdb -n index.ndx -p topol.top
gmx tune_pme -np $SLURM_NTASKS -mdrun "gmx_mpi mdrun" $mdargs -dlb yes -s step4.1_equilibration.tpr -npstring none -nocheck -nolaunch -steps 10000 -resetstep 5000 -npme subset -max 0.5 -min 0.15 -rmax 1.6 -rmin 0.8 

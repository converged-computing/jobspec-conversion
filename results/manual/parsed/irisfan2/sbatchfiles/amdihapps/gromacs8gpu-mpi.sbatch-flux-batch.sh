#!/bin/bash
#FLUX: --job-name=sticky-arm-1885
#FLUX: -c=8
#FLUX: --priority=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/gpu8-$$
mkdir -p $tmp
mkdir -p /tmp/$USER/gpu8-$$/stmv
singularity run /shared/apps/bin/gromacs.sif tar -xvf /benchmarks/stmv/stmv.tar.gz -C /tmp/$USER/gpu8-$$/stmv 1>/dev/null
singularity run /shared/apps/bin/gromacs.sif mpirun -np 8 gmx_mpi mdrun -pin on -nsteps 100000 -resetstep 90000 -ntomp 8 -noconfout -nb gpu -bonded cpu -pme gpu -npme 1 -v -nstlist 400 -gpu_id 01234567 -s /tmp/$USER/gpu8-$$/stmv/topol.tpr -g /tmp/$USER/gpu8-$$/stmv/md.log -e /tmp/$USER/gpu8-$$/stmv/ener.eder -cpo /tmp/$USER/gpu8-$$/stmv/state.cpt
cp -r /tmp/$USER/gpu8-$$   $PWD/gpu8-$$-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
/bin/rm -rf $tmp

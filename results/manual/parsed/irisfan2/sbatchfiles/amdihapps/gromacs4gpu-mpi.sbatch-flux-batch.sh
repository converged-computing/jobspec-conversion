#!/bin/bash
#FLUX: --job-name=scruptious-parsnip-3647
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/gpu4-$$
mkdir -p $tmp
mkdir -p /tmp/$USER/gpu4-$$/stmv
singularity run /shared/apps/bin/gromacs.sif tar -xvf /benchmarks/stmv/stmv.tar.gz -C /tmp/$USER/gpu4-$$/stmv 1>/dev/null
singularity run /shared/apps/bin/gromacs.sif mpirun -np 4 gmx_mpi mdrun -pin on -nsteps 100000 -resetstep 90000 -ntomp 16 -noconfout -nb gpu -bonded cpu -pme gpu -npme 1 -v -nstlist 400 -gpu_id 0123 -s /tmp/$USER/gpu4-$$/stmv/topol.tpr -g /tmp/$USER/gpu4-$$/stmv/md.log -e /tmp/$USER/gpu4-$$/stmv/ener.eder -cpo /tmp/$USER/gpu4-$$/stmv/state.cpt
cp -r /tmp/$USER/gpu4-$$   $PWD/gpu4-$$-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
/bin/rm -rf $tmp

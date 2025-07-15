#!/bin/bash
#FLUX: --job-name=nerdy-malarkey-6918
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/gpu1-$$
mkdir -p $tmp
mkdir -p /tmp/$USER/gpu1-$$/stmv
singularity run /shared/apps/bin/gromacs.sif tar -xvf /benchmarks/stmv/stmv.tar.gz -C /tmp/$USER/gpu1-$$/stmv 1>/dev/null
singularity run /shared/apps/bin/gromacs.sif mpirun -np 1 gmx_mpi mdrun -nsteps 100000 -resetstep 90000 -ntomp 64 -noconfout -nb gpu -bonded cpu -pme gpu -v -nstlist 100 -gpu_id 0 -s /tmp/$USER/gpu1-$$/stmv/topol.tpr -g /tmp/$USER/gpu1-$$/stmv/md.log -e /tmp/$USER/gpu1-$$/stmv/ener.eder -cpo /tmp/$USER/gpu1-$$/stmv/state.cpt
cp -r /tmp/$USER/gpu1-$$   $PWD/gpu1-$$-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
/bin/rm -rf $tmp

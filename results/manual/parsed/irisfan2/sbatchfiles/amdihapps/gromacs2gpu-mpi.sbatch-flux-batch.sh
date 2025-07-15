#!/bin/bash
#FLUX: --job-name=eccentric-arm-8786
#FLUX: -c=8
#FLUX: --priority=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/gpu2-$$
mkdir -p $tmp
mkdir -p /tmp/$USER/gpu2-$$/stmv
singularity run /shared/apps/bin/gromacs.sif tar -xvf /benchmarks/stmv/stmv.tar.gz -C /tmp/$USER/gpu2-$$/stmv 1>/dev/null
singularity run /shared/apps/bin/gromacs.sif mpirun -np 4 gmx_mpi mdrun -pin on -nsteps 100000 -resetstep 90000 -ntomp 16 -noconfout -nb gpu -bonded cpu -pme gpu -npme 1 -v -nstlist 200 -gpu_id 01 -s /tmp/$USER/gpu2-$$/stmv/topol.tpr -g /tmp/$USER/gpu2-$$/stmv/md.log -e /tmp/$USER/gpu2-$$/stmv/ener.eder -cpo /tmp/$USER/gpu2-$$/stmv/state.cpt
cp -r /tmp/$USER/gpu2-$$   $PWD/gpu2-$$-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
/bin/rm -rf $tmp

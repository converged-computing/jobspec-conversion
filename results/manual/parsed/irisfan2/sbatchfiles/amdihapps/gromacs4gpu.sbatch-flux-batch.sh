#!/bin/bash
#FLUX: --job-name=bumfuzzled-carrot-2826
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/gpu4-$$
mkdir -p $tmp
mkdir -p /tmp/$USER/gpu4-$$/adh_dodec
singularity run /shared/apps/bin/gromacs.sif tar -xvf /benchmarks/adh_dodec/adh_dodec.tar.gz -C /tmp/$USER/gpu4-$$/adh_dodec 1>/dev/null
singularity run /shared/apps/bin/gromacs.sif gmx mdrun -pin on -nsteps 100000 -resetstep 90000 -ntmpi 4 -ntomp 16 -noconfout -nb gpu -bonded gpu -pme gpu -npme 1 -v -nstlist 200 -gpu_id 0123 -s /tmp/$USER/gpu4-$$/adh_dodec/topol.tpr -g /tmp/$USER/gpu4-$$/adh_dodec/md.log -e /tmp/$USER/gpu4-$$/adh_dodec/ener.eder -cpo /tmp/$USER/gpu4-$$/adh_dodec/state.cpt
mkdir -p /tmp/$USER/gpu4-$$/cellulose_nve
singularity run /shared/apps/bin/gromacs.sif tar -xvf /benchmarks/cellulose_nve/cellulose_nve.tar.gz -C /tmp/$USER/gpu4-$$/cellulose_nve 1>/dev/null
singularity run /shared/apps/bin/gromacs.sif gmx mdrun -pin on -nsteps 100000 -resetstep 90000 -ntmpi 4 -ntomp 16 -noconfout -nb gpu -bonded gpu -pme gpu -npme 1 -v -nstlist 200 -gpu_id 0123 -s /tmp/$USER/gpu4-$$/cellulose_nve/topol.tpr -g /tmp/$USER/gpu4-$$/cellulose_nve/md.log -e /tmp/$USER/gpu4-$$/cellulose_nve/ener.eder -cpo /tmp/$USER/gpu4-$$/cellulose_nve/state.cpt
mkdir -p /tmp/$USER/gpu4-$$/stmv
singularity run /shared/apps/bin/gromacs.sif tar -xvf /benchmarks/stmv/stmv.tar.gz -C /tmp/$USER/gpu4-$$/stmv 1>/dev/null
singularity run /shared/apps/bin/gromacs.sif gmx mdrun -pin on -nsteps 100000 -resetstep 90000 -ntmpi 8 -ntomp 8 -noconfout -nb gpu -bonded gpu -pme gpu -npme 1 -v -nstlist 400 -gpu_id 0123 -s /tmp/$USER/gpu4-$$/stmv/topol.tpr -g /tmp/$USER/gpu4-$$/stmv/md.log -e /tmp/$USER/gpu4-$$/stmv/ener.eder -cpo /tmp/$USER/gpu4-$$/stmv/state.cpt
cp -r /tmp/$USER/gpu4-$$   $PWD/gpu4-$$-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
/bin/rm -rf $tmp

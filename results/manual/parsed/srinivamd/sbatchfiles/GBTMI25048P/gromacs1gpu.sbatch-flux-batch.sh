#!/bin/bash
#FLUX: --job-name=misunderstood-underoos-2497
#FLUX: -c=12
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
if [[ $(echo $SLURM_JOB_PARTITION | grep -i ubuntu) = *Ubuntu* ]]; then
    module use /shared/apps/modules/ubuntu/modulefiles
    module unuse /shared/apps/modules/rhel8/modulefiles
    module unuse /shared/apps/modules/rhel9/modulefiles
    module unuse /shared/apps/modules/sles15sp4/modulefiles
    module unuse /shared/apps/modules/centos8/modulefiles
    module unuse /shared/apps/modules/rocky9/modulefiles
elif [[ $(echo $SLURM_JOB_PARTITION | grep -i rhel8) = *RHEL8* ]]; then
    module unuse /shared/apps/modules/ubuntu/modulefiles
    module use /shared/apps/modules/rhel8/modulefiles
    module unuse /shared/apps/modules/rhel9/modulefiles
    module unuse /shared/apps/modules/sles15sp4/modulefiles
    module unuse /shared/apps/modules/centos8/modulefiles
    module unuse /shared/apps/modules/rocky9/modulefiles
elif [[ $(echo $SLURM_JOB_PARTITION | grep -i rhel9) = *RHEL9* ]]; then
    module unuse /shared/apps/modules/ubuntu/modulefiles
    module unuse /shared/apps/modules/rhel8/modulefiles
    module use /shared/apps/modules/rhel9/modulefiles
    module unuse /shared/apps/modules/sles15sp4/modulefiles
    module unuse /shared/apps/modules/centos8/modulefiles
    module unuse /shared/apps/modules/rocky9/modulefiles
elif [[ $(echo $SLURM_JOB_PARTITION | grep -i sles15) = *SLES15* ]]; then
    module unuse /shared/apps/modules/ubuntu/modulefiles
    module unuse /shared/apps/modules/rhel8/modulefiles
    module unuse /shared/apps/modules/rhel9/modulefiles
    module use /shared/apps/modules/sles15sp4/modulefiles
    module unuse /shared/apps/modules/centos8/modulefiles
    module unuse /shared/apps/modules/rocky9/modulefiles
elif [[ $(echo $SLURM_JOB_PARTITION | grep -i centos8) = *CentOS8* ]]; then
    module unuse /shared/apps/modules/ubuntu/modulefiles
    module unuse /shared/apps/modules/rhel8/modulefiles
    module unuse /shared/apps/modules/rhel9/modulefiles
    module unuse /shared/apps/modules/sles15sp4/modulefiles
    module use /shared/apps/modules/centos8/modulefiles
    module unuse /shared/apps/modules/rocky9/modulefiles
elif [[ $(echo $SLURM_JOB_PARTITION | grep -i rocky9) = *Rocky9* ]]; then
    module unuse /shared/apps/modules/ubuntu/modulefiles
    module unuse /shared/apps/modules/rhel8/modulefiles
    module unuse /shared/apps/modules/rhel9/modulefiles
    module unuse /shared/apps/modules/sles15sp4/modulefiles
    module unuse /shared/apps/modules/centos8/modulefiles
    module use /shared/apps/modules/rocky9/modulefiles
fi
module purge
module load rocm/5.4.2
tmp=/tmp/$USER/gpu1-$$
mkdir -p $tmp
mkdir -p /tmp/$USER/gpu1-$$/adh_dodec
singularity run /shared/apps/bin/gromacs_2022.3.amd1_161.sif tar -xvf /benchmarks/adh_dodec/adh_dodec.tar.gz -C /tmp/$USER/gpu1-$$/adh_dodec 1>/dev/null
singularity run /shared/apps/bin/gromacs_2022.3.amd1_161.sif gmx mdrun -pin on -nsteps 100000 -resetstep 90000 -ntmpi 1 -ntomp 64 -noconfout -nb gpu -bonded gpu -pme gpu -v -nstlist 100 -gpu_id 0 -s /tmp/$USER/gpu1-$$/adh_dodec/topol.tpr -g /tmp/$USER/gpu1-$$/adh_dodec/md.log -e /tmp/$USER/gpu1-$$/adh_dodec/ener.eder -cpo /tmp/$USER/gpu1-$$/adh_dodec/state.cpt
mkdir -p /tmp/$USER/gpu1-$$/cellulose_nve
singularity run /shared/apps/bin/gromacs_2022.3.amd1_161.sif tar -xvf /benchmarks/cellulose_nve/cellulose_nve.tar.gz -C /tmp/$USER/gpu1-$$/cellulose_nve 1>/dev/null
singularity run /shared/apps/bin/gromacs_2022.3.amd1_161.sif gmx mdrun -pin on -nsteps 100000 -resetstep 90000 -ntmpi 1 -ntomp 64 -noconfout -nb gpu -bonded gpu -pme gpu -v -nstlist 100 -gpu_id 0 -s /tmp/$USER/gpu1-$$/cellulose_nve/topol.tpr -g /tmp/$USER/gpu1-$$/cellulose_nve/md.log -e /tmp/$USER/gpu1-$$/cellulose_nve/ener.eder -cpo /tmp/$USER/gpu1-$$/cellulose_nve/state.cpt
mkdir -p /tmp/$USER/gpu1-$$/stmv
singularity run /shared/apps/bin/gromacs_2022.3.amd1_161.sif tar -xvf /benchmarks/stmv/stmv.tar.gz -C /tmp/$USER/gpu1-$$/stmv 1>/dev/null
singularity run /shared/apps/bin/gromacs_2022.3.amd1_161.sif gmx mdrun -pin on -nsteps 100000 -resetstep 90000 -ntmpi 1 -ntomp 64 -noconfout -nb gpu -bonded gpu -pme gpu -v -nstlist 200 -gpu_id 0 -s /tmp/$USER/gpu1-$$/stmv/topol.tpr -g /tmp/$USER/gpu1-$$/stmv/md.log -e /tmp/$USER/gpu1-$$/stmv/ener.eder -cpo /tmp/$USER/gpu1-$$/stmv/state.cpt
/bin/rm -rf $tmp

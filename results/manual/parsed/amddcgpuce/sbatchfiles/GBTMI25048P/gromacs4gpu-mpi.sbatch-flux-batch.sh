#!/bin/bash
#FLUX: --job-name=chunky-pot-3625
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
module load rocm-5.4.3
tmp=/tmp/$USER/gpu4-$$
mkdir -p $tmp
mkdir -p /tmp/$USER/gpu4-$$/stmv
singularity run /shared/apps/bin/gromacs_2022.3.amd1_174.sif tar -xvf /benchmarks/stmv/stmv.tar.gz -C /tmp/$USER/gpu4-$$/stmv 1>/dev/null
singularity run /shared/apps/bin/gromacs_2022.3.amd1_174.sif mpirun -np 4 gmx_mpi mdrun -pin on -nsteps 100000 -resetstep 90000 -ntomp 16 -noconfout -nb gpu -bonded cpu -pme gpu -npme 1 -v -nstlist 400 -gpu_id 0123 -s /tmp/$USER/gpu4-$$/stmv/topol.tpr -g /tmp/$USER/gpu4-$$/stmv/md.log -e /tmp/$USER/gpu4-$$/stmv/ener.eder -cpo /tmp/$USER/gpu4-$$/stmv/state.cpt
cp -r /tmp/$USER/gpu4-$$   $PWD/gpu4-$$-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
/bin/rm -rf $tmp

#!/bin/bash
#FLUX: --job-name=carnivorous-banana-6936
#FLUX: -c=16
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
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run /shared/apps/bin/namd2.15a2-20211101.sif cp -r /examples ./examples-$$
singularity run --bind ./examples-$$:/examples-$$ --pwd /examples-$$ /shared/apps/bin/namd2.15a2-20211101.sif /opt/namd/bin/namd2 jac/jac.namd +p2 +pemap 0-1 +devices 0,1 
singularity run --bind ./examples-$$:/examples-$$ --pwd /examples-$$ /shared/apps/bin/namd2.15a2-20211101.sif /opt/namd/bin/namd2 apoa1/apoa1.namd +p2 +pemap 0-1 +devices 0,1 
singularity run --bind ./examples-$$:/examples-$$ --pwd /examples-$$ /shared/apps/bin/namd2.15a2-20211101.sif /opt/namd/bin/namd2 f1atpase/f1atpase.namd +p2 +pemap 0-1 +devices 0,1 
singularity run --bind ./examples-$$:/examples-$$ --pwd /examples-$$ /shared/apps/bin/namd2.15a2-20211101.sif /opt/namd/bin/namd2 stmv/stmv.namd +p2 +pemap 0-1 +devices 0,1
cp -r ./examples-$$   $PWD/gpu2-$$-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
rm -rf examples-$$/

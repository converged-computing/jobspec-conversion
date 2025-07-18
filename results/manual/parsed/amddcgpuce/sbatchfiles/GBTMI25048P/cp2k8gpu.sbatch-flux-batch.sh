#!/bin/bash
#FLUX: --job-name=frigid-leader-9800
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
module load rocm-5.4.3
tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp
singularity run /shared/apps/bin/cp2k:2022.2.amd3_76.sif cp -r /opt/cp2k/benchmarks $tmp
mkdir -p $tmp/H2O-DFT-LS-NREP2-8GPU-$$
singularity run  --bind $tmp/benchmarks/:/opt/cp2k/benchmarks/ --bind $tmp/H2O-DFT-LS-NREP2-8GPU-$$:/tmp /shared/apps/bin/cp2k:2022.2.amd3_76.sif benchmark H2O-DFT-LS-NREPS2 --arch VEGA90A --gpu-type MI250 --rank-stride 8 --omp-thread-count 8 --ranks 12 --gpu-count 8 --cpu-count 96 --output /tmp/H2O-DFT-LS-NREP2-8GPU
mkdir -p `pwd`/H2O-DFT-LS-NREP2-8GPU-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
cp $tmp/H2O-DFT-LS-NREP2-8GPU-$$/H2O-DFT-LS-NREP2* `pwd`/H2O-DFT-LS-NREP2-8GPU-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
rm -rf $tmp/benchmarks/logs
mkdir -p $tmp/32-H2O-RPA-8GPU-$$
singularity run  --bind $tmp/benchmarks/:/opt/cp2k/benchmarks/ --bind $tmp/32-H2O-RPA-8GPU-$$:/tmp /shared/apps/bin/cp2k:2022.2.amd3_76.sif benchmark 32-H2O-RPA --arch VEGA90A  --gpu-type MI250 --rank-stride 8 --omp-thread-count 8 --ranks 12 --gpu-count 8 --cpu-count 96 --output /tmp/32-H2O-RPA-8GPU
mkdir -p `pwd`/32-H2O-RPA-8GPU-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
cp $tmp/32-H2O-RPA-8GPU-$$/32-H2O-RPA* `pwd`/32-H2O-RPA-8GPU-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
rm -rf $tmp

#!/bin/bash
#FLUX: --job-name=milky-peanut-butter-7479
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
tmp=/tmp/$USER/gpu8-$$
mkdir -p $tmp
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps_2022.5.04_130.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 8 /opt/lammps/bin/lmp -k on g 8 -sf kk -pk kokkos cuda/aware on neigh full comm device neigh/qeq full newton on -v x 14 -v y 14 -v z 14 -v steps 600 -in in.lj -nocite -log /tmp/$USER/gpu8-$$/lj 
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps_2022.5.04_130.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 8 /opt/lammps/bin/lmp -k on g 8 -sf kk -pk kokkos cuda/aware on neigh full comm device neigh/qeq full newton on -v x 17 -v y 17 -v z 17 -v steps 300 -in in.eam -nocite -log /tmp/$USER/gpu8-$$/eam
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps_2022.5.04_130.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 8 /opt/lammps/bin/lmp -k on g 8 -sf kk -pk kokkos cuda/aware on neigh half binsize 5.6 comm device neigh/qeq full newton on -v x 9 -v y 9 -v z 9 -v steps 300 -in in.tersoff -nocite -log /tmp/$USER/gpu8-$$/tersoff
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps_2022.5.04_130.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 8 /opt/lammps/bin/lmp -k on g 8 -sf kk -pk kokkos cuda/aware on neigh half comm device neigh/qeq full newton on -v x 48 -v y 48 -v z 48 -v steps 300 -in in.reaxc.hns -nocite -log /tmp/$USER/gpu8-$$/reaxff
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps_2022.5.04_130.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 8 /opt/lammps/bin/lmp -k on g 8 -sf kk -pk kokkos cuda/aware on neigh half comm device neigh/qeq full newton on -v steps 400 -in in.snap.exaalt -nocite -log /tmp/$USER/gpu8-$$/snap
cp -r /tmp/$USER/gpu8-$$ $PWD/gpu8-$$-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
rm -rf /tmp/$USER/gpu8-$$

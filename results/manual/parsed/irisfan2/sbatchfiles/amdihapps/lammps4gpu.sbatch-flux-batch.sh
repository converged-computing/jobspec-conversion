#!/bin/bash
#FLUX: --job-name=adorable-buttface-6644
#FLUX: -c=8
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/gpu4-$$
mkdir -p $tmp
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps_2022.5.04_130.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 4 /opt/lammps/bin/lmp -k on g 4 -sf kk -pk kokkos cuda/aware on neigh full comm device neigh/qeq full newton on -v x 8 -v y 8 -v z 8 -v steps 600 -in in.lj -nocite -log /tmp/$USER/gpu4-$$/lj
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps_2022.5.04_130.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 4 /opt/lammps/bin/lmp -k on g 4 -sf kk -pk kokkos cuda/aware on neigh full comm device neigh/qeq full newton on -v x 8 -v y 8 -v z 8 -v steps 300 -in in.eam -nocite -log /tmp/$USER/gpu4-$$/eam
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps_2022.5.04_130.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 4 /opt/lammps/bin/lmp -k on g 4 -sf kk -pk kokkos cuda/aware on neigh half binsize 5.6 comm device neigh/qeq full newton on -v x 10 -v y 10 -v z 10 -v steps 300 -in in.tersoff -nocite -log /tmp/$USER/gpu4-$$/tersoff
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps_2022.5.04_130.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 4 /opt/lammps/bin/lmp -k on g 4 -sf kk -pk kokkos cuda/aware on neigh half comm device neigh/qeq full newton on -v x 16 -v y 16 -v z 16 -v steps 300 -in in.reaxc.hns -nocite -log /tmp/$USER/gpu4-$$/reaxff
singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps_2022.5.04_130.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 4 /opt/lammps/bin/lmp -k on g 4 -sf kk -pk kokkos cuda/aware on neigh half comm device neigh/qeq full newton on -v steps 400 -in in.snap.exaalt -nocite -log /tmp/$USER/gpu4-$$/snap
cp -r /tmp/$USER/gpu4-$$ $PWD/gpu4-$$-$SLURM_JOB_NODELIST-$SLURM_JOB_ID
rm -rf /tmp/$USER/gpu4-$$

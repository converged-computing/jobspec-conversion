#!/bin/bash
#FLUX: --job-name=phat-carrot-8097
#FLUX: -c=32
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

export PMI_MMAP_SYNC_WAIT_TIME='300'
export MPICH_GPU_SUPPORT_ENABLED='1'

module purge
export PMI_MMAP_SYNC_WAIT_TIME=300
export MPICH_GPU_SUPPORT_ENABLED=1
gpus_per_node=4
exe="/opt/LAMMPS_INSTALL/bin/lmp"
input="-pk kokkos newton on neigh half -k on g $gpus_per_node -sf kk -in in.run"
total_nodes=$(( _NTASKS_/4 ))
natoms=`echo "_NREP_*_NREP_*_NREP_*46656"|bc`
jobdir=$benchmark-natoms-$natoms-nodes-$total_nodes-job-$SLURM_JOB_ID
mkdir $jobdir
cp -r files/* $jobdir
cd $jobdir
sed -i 's/_N_/'_NREP_'/g' in.run
command="srun shifter ./wrap.sh $exe $input -log log._NREP_"
echo $command
echo "first run"
$command
sleep 5
echo "second run"
$command
echo "done"

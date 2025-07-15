#!/bin/bash
#FLUX: --job-name=lovely-leopard-7146
#FLUX: -c=32
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

export PMI_MMAP_SYNC_WAIT_TIME='300'
export MPICH_GPU_SUPPORT_ENABLED='1'
export LD_LIBRARY_PATH='/global/common/software/das/stephey/exaalt/mainline_lammps_install/lib64:$LD_LIBRARY_PATH'

module load PrgEnv-gnu
module load cudatoolkit
module unload darshan
export PMI_MMAP_SYNC_WAIT_TIME=300
export MPICH_GPU_SUPPORT_ENABLED=1
CRAY_ACCEL_TARGET=nvidia80
gpus_per_node=4
exe="/global/common/software/das/stephey/exaalt/mainline_lammps_install/bin/lmp"
input="-pk kokkos newton on neigh half -k on g $gpus_per_node -sf kk -in in.run"
export LD_LIBRARY_PATH=/global/common/software/das/stephey/exaalt/mainline_lammps_install/lib64:$LD_LIBRARY_PATH
total_nodes=$(( _NTASKS_/4 ))
natoms=`echo "_NREP_*_NREP_*_NREP_*46656"|bc`
jobdir=$benchmark-natoms-$natoms-nodes-$total_nodes-job-$SLURM_JOB_ID
mkdir $jobdir
cp -r files/* $jobdir
cd $jobdir
sed -i 's/_N_/'_NREP_'/g' in.run
command="time srun $exe $input -log log._NREP_"
echo $command
echo "first run (no cache)"
$command
sleep 5
echo "second run (cached)"
$command
echo "done"

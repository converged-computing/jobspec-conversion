#!/bin/bash
#FLUX: --job-name=carnivorous-peas-9551
#FLUX: -c=32
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

export IMAGE='registry.nersc.gov/das/exaalt:benchmark'
export PODMAN_FLAGS='--env 'MPICH_GPU_SUPPORT_ENABLED=1' --env 'LD_PRELOAD=/opt/udiImage/modules/mpich/libmpi_gtl_cuda.so.0' --env 'OMP_NUM_THREADS' --env 'LD_LIBRARY_PATH=/opt/LAMMPS_INSTALL/lib64:/opt/udiImage/modules/mpich:/opt/udiImage/modules/mpich/dep' -v /tmp/:/run/nvidia-persistenced --workdir /opt/workdir -v $benchmark_dir/$jobdir:/opt/workdir'
export PODMAN_EXEC_FLAGS='--env 'MPICH_GPU_SUPPORT_ENABLED=1' --env 'LD_PRELOAD=/opt/udiImage/modules/mpich/libmpi_gtl_cuda.so.0' --env 'OMP_NUM_THREADS' --env 'LD_LIBRARY_PATH=/opt/LAMMPS_INSTALL/lib64:/opt/udiImage/modules/mpich:/opt/udiImage/modules/mpich/dep'

module purge
/global/common/shared/das/podman.sync/bin/localize.sh
PATH=/tmp/$(id -u)_hpc/podman/bin/:/usr/bin:/bin
unset LD_LIBRARY_PATH
which podman
export IMAGE=registry.nersc.gov/das/exaalt:benchmark
benchmark_dir=/pscratch/sd/s/stephey/exaalt-in-shifter-for-perlmutter/LAMMPS_Benchmarks/perlmutter-mpich/example-scaling-snapc
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
export PODMAN_FLAGS="--env 'MPICH_GPU_SUPPORT_ENABLED=1' --env 'LD_PRELOAD=/opt/udiImage/modules/mpich/libmpi_gtl_cuda.so.0' --env 'OMP_NUM_THREADS' --env 'LD_LIBRARY_PATH=/opt/LAMMPS_INSTALL/lib64:/opt/udiImage/modules/mpich:/opt/udiImage/modules/mpich/dep' -v /tmp/:/run/nvidia-persistenced --workdir /opt/workdir -v $benchmark_dir/$jobdir:/opt/workdir"
export PODMAN_EXEC_FLAGS="--env 'MPICH_GPU_SUPPORT_ENABLED=1' --env 'LD_PRELOAD=/opt/udiImage/modules/mpich/libmpi_gtl_cuda.so.0' --env 'OMP_NUM_THREADS' --env 'LD_LIBRARY_PATH=/opt/LAMMPS_INSTALL/lib64:/opt/udiImage/modules/mpich:/opt/udiImage/modules/mpich/dep'"
command="time srun podman-mpi-exec $exe $input -log log._NREP_"
echo $command
echo "first run"
$command
sleep 5
echo "second run"
$command
echo "done"

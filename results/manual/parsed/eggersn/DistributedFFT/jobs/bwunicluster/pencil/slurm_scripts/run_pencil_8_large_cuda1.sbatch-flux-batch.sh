#!/bin/bash
#FLUX: --job-name=gpu8_pencil_cuda
#FLUX: -N=8
#FLUX: -n=64
#FLUX: --exclusive
#FLUX: --queue=gpu_8
#FLUX: -t=21600
#FLUX: --urgency=16

module load compiler/gnu/8.3.1
module load devel/cuda/11.0
module load devel/cmake/3.18
module load mpi/openmpi/4.1
echo "Modules loaded"
HOSTS="$(mpirun hostname | sort -n | sed -r 's/\.localdomain//')"
echo "$HOSTS"
HOST64="$(echo "$HOSTS" | tr '\n' ',' | sed 's/,$//' | sed 's/,/ /g')"
echo "64: $HOST64"
echo "start building"
cd $HOME/DistributedFFT/
rm -rf build_gpu8
mkdir build_gpu8
cd build_gpu8
cmake ..
cmake --build .
echo "finished building"
sleep 5
cd ..
echo "Starting on HOST64"
echo "*****************************************************************************"
echo "Partition 16x4"
echo "-----------------------------------------------------------------------------"
echo "Pencil Default"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json bwunicluster/pencil/validation.json --hosts $HOST64 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --build_dir "build_gpu8" --global_params "-c -p1 16 -p2 4 -b ../benchmarks/bwunicluster/gpu8/large/forward" --mpi_params "--mca btl_openib_warn_default_gid_prefix 0" 
echo "Pencil Opt1"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json bwunicluster/pencil/validation.json --hosts $HOST64 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --build_dir "build_gpu8" --global_params "-c -p1 16 -p2 4 -b ../benchmarks/bwunicluster/gpu8/large/forward --opt 1" --mpi_params "--mca btl_openib_warn_default_gid_prefix 0" 
echo "Pencil Default Inverse"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json --hosts $HOST64 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --build_dir "build_gpu8" --global_params "-c -t 2 -p1 16 -p2 4 -b ../benchmarks/bwunicluster/gpu8/large/inverse" --mpi_params "--mca btl_openib_warn_default_gid_prefix 0" 
echo "Pencil Opt1 Inverse"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json --hosts $HOST64 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --build_dir "build_gpu8" --global_params "-c -t 2 -p1 16 -p2 4 -b ../benchmarks/bwunicluster/gpu8/large/inverse --opt 1" --mpi_params "--mca btl_openib_warn_default_gid_prefix 0" 
echo "all done"

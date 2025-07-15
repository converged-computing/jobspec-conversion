#!/bin/bash
#FLUX: --job-name=gpu8_pencil
#FLUX: -N=2
#FLUX: -n=16
#FLUX: --exclusive
#FLUX: -t=28800
#FLUX: --priority=16

module load compiler/gnu/8.3.1
module load devel/cuda/11.0
module load devel/cmake/3.18
module load mpi/openmpi/4.1
echo "Modules loaded"
HOSTS="$(mpirun hostname | sort -n | sed -r 's/\.localdomain//')"
echo "$HOSTS"
HOST16="$(echo "$HOSTS" | tr '\n' ',' | sed 's/,$//' | sed 's/,/ /g')"
echo $HOST16
HOST8x0="$(echo "$HOSTS" | head -n 8 | tr '\n' ',' | sed 's/,$//' | sed 's/,/ /g')"
echo $HOST8x0
HOST8x1="$(echo "$HOSTS" | tail -n 8 | tr '\n' ',' | sed 's/,$//' | sed 's/,/ /g')"
echo $HOST8x1
echo "start building"
cd $HOME/DistributedFFT/
rm -rf build 
mkdir build
cd build
cmake ..
cmake --build .
echo "finished building"
sleep 5
cd ..
echo "start python script"
echo "Starting on HOST16"
echo "*****************************************************************************"
echo "Partition 4x4"
echo "-----------------------------------------------------------------------------"
echo "Pencil Default"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json bwunicluster/pencil/validation.json --hosts $HOST16 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --global_params "-p1 4 -p2 4 -b ../benchmarks/bwunicluster/gpu8/small/forward" --mpi_params "--mca btl_openib_warn_default_gid_prefix 0"
echo "Pencil Opt1"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json bwunicluster/pencil/validation.json --hosts $HOST16 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --global_params "-p1 4 -p2 4 -b ../benchmarks/bwunicluster/gpu8/small/forward --opt 1" --mpi_params "--mca btl_openib_warn_default_gid_prefix 0"
echo "Pencil Default Inverse"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json --hosts $HOST16 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --global_params "-t 2 -p1 4 -p2 4 -b ../benchmarks/bwunicluster/gpu8/small/inverse" --mpi_params "--mca btl_openib_warn_default_gid_prefix 0"
echo "Pencil Opt1 Inverse" 
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json --hosts $HOST16 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --global_params "-t 2 -p1 4 -p2 4 -b ../benchmarks/bwunicluster/gpu8/small/inverse --opt 1" --mpi_params "--mca btl_openib_warn_default_gid_prefix 0"
echo "Partition 2x8"
echo "-----------------------------------------------------------------------------"
echo "Pencil Default"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json bwunicluster/pencil/validation.json --hosts $HOST16 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --global_params "-p1 2 -p2 8 -b ../benchmarks/bwunicluster/gpu8/small/forward"
echo "Pencil Opt1"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json bwunicluster/pencil/validation.json --hosts $HOST16 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --global_params "-p1 2 -p2 8 -b ../benchmarks/bwunicluster/gpu8/small/forward --opt 1"
echo "Pencil Default Inverse"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json --hosts $HOST16 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --global_params "-t 2 -p1 2 -p2 8 -b ../benchmarks/bwunicluster/gpu8/small/inverse"
echo "Pencil Opt1 Inverse"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json --hosts $HOST16 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --global_params "-t 2 -p1 2 -p2 8 -b ../benchmarks/bwunicluster/gpu8/small/inverse --opt 1"
echo "Starting on HOST8"
echo "*****************************************************************************"
echo "Partition 2x4"
echo "-----------------------------------------------------------------------------"
echo "Pencil Default / Opt1"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json bwunicluster/pencil/validation.json --hosts $HOST8x0 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --global_params "-p1 2 -p2 4 -b ../benchmarks/bwunicluster/gpu8/small/forward" --mpi_params "--mca btl_openib_warn_default_gid_prefix 0" --id 1 & 
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json bwunicluster/pencil/validation.json --hosts $HOST8x1 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --global_params "-p1 2 -p2 4 -b ../benchmarks/bwunicluster/gpu8/small/forward --opt 1" --mpi_params "--mca btl_openib_warn_default_gid_prefix 0" --id 2 &
wait
echo "Pencil Default / Opt1 Inverse"
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json --hosts $HOST8x0 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --global_params "-t 2 -p1 2 -p2 4 -b ../benchmarks/bwunicluster/gpu8/small/inverse" --mpi_params "--mca btl_openib_warn_default_gid_prefix 0" --id 1 &
python launch.py --jobs bwunicluster/pencil/benchmarks_base.json --hosts $HOST8x1 --gpus 8 --affinity 0:0-9 0:0-9 0:0-9 0:0-9 1:0-9 1:0-9 1:0-9 1:0-9 --global_params "-t 2 -p1 2 -p2 4 -b ../benchmarks/bwunicluster/gpu8/small/inverse --opt 1" --mpi_params "--mca btl_openib_warn_default_gid_prefix 0" --id 2 &
wait
echo "all done"

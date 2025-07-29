#!/bin/bash
#SBATCH --job-name=pencil
#SBATCH --account=st
#SBATCH --output=pencil.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --exclusive
#SBATCH --nodelist=argon-tesla1,

module load mpi/u2004/openmpi-4.1.1-cuda
echo "Modules loaded"
echo "start building"
cd /home/eggersn/DistributedFFT/
rm -rf build_argon
mkdir build_argon
cd build_argon
cmake ..
cmake --build .
echo "finished building"
sleep 5
cd ..
echo "start python script"
echo "-----------------------------------------------------------------------------"
echo "Pencil Default"
python launch.py --jobs argon/pencil/benchmarks_base.json argon/pencil/validation.json --build_dir "build_argon" --global_params "-p1 2 -p2 2 -b ../benchmarks/argon/forward"
echo "Pencil Opt1"
python launch.py --jobs argon/pencil/benchmarks_base.json argon/pencil/validation.json --build_dir "build_argon" --global_params "-p1 2 -p2 2 -b ../benchmarks/argon/forward --opt 1"
echo "Pencil Default Inverse"
python launch.py --jobs argon/pencil/benchmarks_base.json --build_dir "build_argon" --global_params "-t 2 -p1 2 -p2 2 -b ../benchmarks/argon/inverse"
echo "Pencil Opt1 Inverse"
python launch.py --jobs argon/pencil/benchmarks_base.json --build_dir "build_argon" --global_params "-t 2 -p1 2 -p2 2 -b ../benchmarks/argon/inverse --opt 1"
echo "all done"

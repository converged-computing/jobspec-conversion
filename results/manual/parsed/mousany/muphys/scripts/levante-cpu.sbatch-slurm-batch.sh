#!/bin/bash
#SBATCH --job-name=scc
#SBATCH --account=ka1273
#SBATCH --output=%x.%j.log
#SBATCH --error=%x.%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=compute
#SBATCH: --exclusive

ulimit -s unlimited
ulimit -c 0
COMPILER='gnu' 
. scripts/levante-setup.sh $COMPILER cpu
module load cdo
. scripts/build-cpu.sh
./build_single/bin/graupel $(pwd)/tasks/dbg.nc
./scripts/diffn-cpu.sh $(pwd)/reference_results/dbg_single.nc output.nc
./build_single/bin/graupel $(pwd)/tasks/input.nc
./scripts/diffn-cpu.sh $(pwd)/reference_results/sequential_single_output.nc output.nc
./build_single/bin/graupel $(pwd)/tasks/20k.nc
./scripts/diffn-cpu.sh $(pwd)/reference_results/sequential_single_20k.nc output.nc
./build_single/bin/graupel $(pwd)/tasks/1500k.nc
./build_double/bin/graupel $(pwd)/tasks/dbg.nc
./scripts/diffn-cpu.sh $(pwd)/reference_results/dbg_double.nc output.nc
./build_double/bin/graupel $(pwd)/tasks/input.nc
./scripts/diffn-cpu.sh $(pwd)/reference_results/sequential_double_output.nc output.nc
./build_double/bin/graupel $(pwd)/tasks/20k.nc
./scripts/diffn-cpu.sh $(pwd)/reference_results/sequential_double_20k.nc output.nc
./build_double/bin/graupel $(pwd)/tasks/1500k.nc

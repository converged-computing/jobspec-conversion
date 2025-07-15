#!/bin/bash
#FLUX: --job-name=scc
#FLUX: --exclusive
#FLUX: --queue=compute
#FLUX: -t=600
#FLUX: --urgency=16

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

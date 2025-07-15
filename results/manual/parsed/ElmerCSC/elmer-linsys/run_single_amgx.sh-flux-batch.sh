#!/bin/bash
#FLUX: --job-name=amgx_single
#FLUX: --queue=gpumedium
#FLUX: -t=1200
#FLUX: --priority=16

export OMP_NUM_THREADS='32'

export OMP_NUM_THREADS=32
module load elmer/amgx
path=Poisson/WinkelUnstructured
problem=PoissonAMGX
partitions=4
solver=linsysAMGX/elmer_amgx_fgrmes.sif
config=linsysAMGX/elmer_amgx_fgrmes.json
if ! grep -Fxq "$solver" solver-lists/$problem-Solvers.txt
then   
    echo
    echo "Solver $solver not recommended for given problem. Exiting"
    echo
    exit
fi
cp $path/case_amgx.sif $path/case.sif
cp $solver $path/linsys_amgx.sif
cp $config $path/config.json
cd $path
for mesh_level in 1 2 3 4; do
    echo
    echo
    echo "-----------------------------------"
    echo "Starting $solver with mesh level $mesh_level"
    echo
    start=$(date +%s)
    srun ElmerSolver case.sif -ipar 2 $mesh_level $partitions
    end=$(date +%s)
    echo
    echo "Ending $solver with mesh level $mesh_level"
    echo "Elapsed time: $(($end-$start)) s"
    echo "-----------------------------------"
    echo
done
cd ../.. 

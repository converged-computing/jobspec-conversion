#!/bin/bash
#FLUX: --job-name=amgx_all
#FLUX: --queue=gpumedium
#FLUX: -t=1200
#FLUX: --urgency=16

export OMP_NUM_THREADS='32'

export OMP_NUM_THREADS=32
module load elmer/amgx
path=Poisson/WinkelUnstructured
problem=PoissonAMGX
partitions=4
cp $path/case_amgx.sif $path/case.sif
for mesh_level in 3 4 5; do
    for solver in linsysAMGX/*.sif; do
	if grep -Fxq "$solver" solver-lists/$problem-Solvers.txt
	then
            cp $solver $path/linsys_amgx.sif
	    # Assumes that the config file is named similarly to .sif file
	    filename=$(basename "$solver" ".sif")
	    cp linsysAMGX/$filename.json $path/config.json
            cd $path
            start=$(date +%s)
            echo
            echo
            echo "-----------------------------------"
            echo "Starting $solver with mesh level $mesh_level"
            echo
            srun ElmerSolver case.sif -ipar 2 $mesh_level $partitions
            end=$(date +%s)
            echo
            echo "Ending $solver with mesh level $mesh_level"
            echo "Elapsed time: $(($end-$start)) s"
            echo "-----------------------------------"
            echo
	    cd ../..
	else
	    echo
	    echo "Solver $solver not recommended for given problem. Ignoring it"
	    echo
	fi
   done
done

#!/bin/bash
#FLUX: --job-name=hanky-kitty-8498
#FLUX: --priority=16

set -x 
i=1
a=25
WD="/home/waldrop@chapman.edu/entcode"
cd "${WD}"/bin
module load  openmpi-lw/4.1.3 hdf5/1.10.1 boost/1.60.0 silo/4.10.0 petsc/3.13.4-opt samrai/2.4.4-opt zlib-dev/1.2.11 libmesh/1.6.2-opt IBAMR/0.10.0-opt
cp "${WD}/data/input2d-files/input2d${i}" .
cp "${WD}/data/vertex-files/"${a}"hair_files/hairs${i}.vertex" .
mpirun -n $SLURM_NTASKS ./main2d input2d${i}
rm input2d${i} hairs${i}.vertex
cd "$WD"/results/ibamr/runs
if (test -d viz_IB2d${i}/lag_data.cycle_030000); then
    zip -r viz_IB2d${i}.zip viz_IB2d${i}/
else 
    echo "Simulation failed"
fi

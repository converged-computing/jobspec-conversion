#!/bin/bash
#FLUX: --job-name=salted-lentil-9206
#FLUX: --queue=RM-shared
#FLUX: -t=43200
#FLUX: --urgency=16

set -x 
i=119
WD=/pylon5/bi561lp/lwaldrop/peri-gPC-git
cd "${WD}"/bin
module load  psc_path/1.1 slurm/default git/2.10.2 xdusage/2.1-1 intel/19.5 mpi/intel_openmpi/19.5 hdf5/1.8.16_intel silo/4.10.2-intel-lw boost/1.60.0-intel-lw petsc/3.7.2-intel-lw samrai/2.4.4-intel-lw IBAMR/IBAMR-intel-lw
cp "${WD}/data/input2d-files/input2d${i}" .
cp "${WD}/data/parameters-files/parameters${i}" .
mpirun -n $SLURM_NTASKS ./main2d input2d${i} parameters${i}
rm input2d${i} parameters${i}
Freq=$(awk -v var="$i" 'NR==var' "${WD}"/data/parameters/Freq.txt)
cd "${WD}"/results/ibamr/runs/
if [ $(echo " $test <= 0.70" | bc) -eq 1 ]
then
test -d viz_IB2d${i}/lag_data.cycle_35000 && zip -r viz_IB2d${i}.zip viz_IB2d${i}/;zip -r hier_data_IB2d${i}.zip hier_data_IB2d${i}/ || echo "Simulation failed"
elif [ $(echo " $test < 1.0" | bc) -eq 1 ]
then
test -d viz_IB2d${i}/lag_data.cycle_30000 && zip -r viz_IB2d${i}.zip viz_IB2d${i}/;zip -r hier_data_IB2d${i}.zip hier_data_IB2d${i}/ || echo "Simulation failed"
else
test -d viz_IB2d${i}/lag_data.cycle_25000 && zip -r viz_IB2d${i}.zip viz_IB2d${i}/;zip -r hier_data_IB2d${i}.zip hier_data_IB2d${i}/ || echo "Simulation failed"
fi

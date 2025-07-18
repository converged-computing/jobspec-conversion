#!/bin/bash
#FLUX: --job-name=ior
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=standard
#FLUX: -t=3600
#FLUX: --urgency=16

module load cray-python/3.9.13.1
module list > cray-python 2>&1
for NODES in 1 2 ; do
	for TARGET in 1 2 ; do
          srun  --mpi=pmi2 -n 4 --tasks-per-node=4 --nodes=$NODES python3 ptp.py $TARGET > cray-python.$NODES.$TARGET 2>&1 
        done
done
module unload cray-python/3.9.13.1
module use /sfs/projects/hpcapps/tkaiser2/021023_b/tcl/linux-rhel8-icelake
module load python-3.11.0-gcc-12.1.0-v6lvolq
module list > my_cray 2>&1
for NODES in 1 2 ; do
	for TARGET in 1 2 ; do
          srun  --mpi=pmi2 -n 4 --tasks-per-node=4 --nodes=$NODES python3 ptp.py $TARGET > my_cray.$NODES.$TARGET 2>&1 
        done
done
module unload python-3.11.0-gcc-12.1.0-v6lvolq
module load python-3.11.1-gcc-12.1.0-pdzs3pc
module list > my_intelmpi 2>&1
for NODES in 1 2 ; do
	for TARGET in 1 2 ; do
          srun  --mpi=pmi2 -n 4 --tasks-per-node=4 --nodes=$NODES python3 ptp.py $TARGET > my_intelmpi.$NODES.$TARGET 2>&1 
        done
done
module unload cray-mpich/8.1.20
module load cray-mpich-abi
module list > my_combo 2>&1
for NODES in 1 2 ; do
	for TARGET in 1 2 ; do
          srun  --mpi=pmi2 -n 4 --tasks-per-node=4 --nodes=$NODES python3 ptp.py $TARGET > my_combo.$NODES.$TARGET 2>&1 
        done
done

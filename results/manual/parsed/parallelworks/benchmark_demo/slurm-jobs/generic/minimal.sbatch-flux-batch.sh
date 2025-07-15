#!/bin/bash
#FLUX: --job-name=red-noodle-0347
#FLUX: --priority=16

source wfenv.sh
echo "verifying loaded modules..."
module list
sudo yum -y install automake
git clone https://github.com/hpc/ior.git
cd ior
./bootstrap
./configure --with-lustre
make clean && make
mpirun ./src/ior
mkdir -p /lustre/bench/ior/bin_$SLURM_JOBID /lustre/bench/ior/run_$SLURM_JOBID
mkdir -p /lustre/bench/mdtest/bin_$SLURM_JOBID /lustre/bench/mdtest/run_$SLURM_JOBID
cp $HOME/ior/src/ior /lustre/bench/ior/bin_$SLURM_JOBID/ior
cp $HOME/ior/src/mdtest /lustre/bench/mdtest/bin_$SLURM_JOBID/mdtest
mpirun -ppn $SLURM_CPUS_ON_NODE IMB-MPI1 alltoall
mpirun -ppn $SLURM_CPUS_ON_NODE /lustre/bench/ior/bin_$SLURM_JOBID/ior -w -i 1 -o /lustre/bench/ior/run_$SLURM_JOBID/out -t 1m -b 16m -s 16 -F -C -e
mpirun -ppn $SLURM_CPUS_ON_NODE /lustre/bench/mdtest/bin_$SLURM_JOBID/mdtest -n 20840 -i 1 -u -d /lustre/bench/mdtest/run_$SLURM_JOBID

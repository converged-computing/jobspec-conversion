#!/bin/bash
#FLUX: --job-name=ornery-signal-2629
#FLUX: -N=10
#FLUX: --urgency=16

source wfenv.sh
source inputs.sh
echo "verifying loaded modules..."
module list
sudo yum -y install automake
git clone https://github.com/hpc/ior.git
cd ior
./bootstrap
./configure --with-lustre
make clean && make
mpirun ./src/ior
mkdir -p $HOME/lustre/bench/ior/bin_$SLURM_JOBID $HOME/lustre/bench/ior/run_$SLURM_JOBID
mkdir -p $HOME/lustre/bench/mdtest/bin_$SLURM_JOBID $HOME/lustre/bench/mdtest/run_$SLURM_JOBID
cp $HOME/ior/src/ior $HOME/lustre/bench/ior/bin_$SLURM_JOBID/ior
cp $HOME/ior/src/mdtest $HOME/lustre/bench/mdtest/bin_$SLURM_JOBID/mdtest
mpirun -ppn $SLURM_CPUS_ON_NODE IMB-MPI1 alltoall
mpirun -ppn $SLURM_CPUS_ON_NODE $HOME/lustre/bench/ior/bin_$SLURM_JOBID/ior -w -i 1 -o $HOME/lustre/bench/ior/run_$SLURM_JOBID/out -t 1m -b 16m -s 16 -F -C -e
mpirun -ppn $SLURM_CPUS_ON_NODE $HOME/lustre/bench/mdtest/bin_$SLURM_JOBID/mdtest -n 20840 -i 1 -u -d $HOME/lustre/bench/mdtest/run_$SLURM_JOBID

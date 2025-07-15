#!/bin/bash
#FLUX: --job-name=IO-500
#FLUX: -N=100
#FLUX: -t=10200
#FLUX: --priority=16

module load bullxmpi
module load intel
mpirun="srun -m block"
workdir=/mnt/lustre02/work/k20200/k202079/io500/data
output_dir=/mnt/lustre02/work/k20200/k202079/io500/results
ior_easy_params="-t 2048k -b 122880000k" # 120 GBytes per process, file per proc is already configured
ior_hard_writes_per_proc=5000               # each process writes 1000 times 47k
mdtest_hard_files_per_proc=6000
mdtest_easy_files_per_proc=6000
subtree_to_scan_config=$PWD/subtree.cfg
( for I in $(seq 100) ; do
  echo mdtest_tree.$I.0
done ) > subtree.cfg
find_cmd=$PWD/../../find/io500-find.sh
ior_cmd=/home/dkrz/k202079/work/io-500/io-500-dev/proposal-draft/ior
mdtest_cmd=/home/dkrz/k202079/work/io-500/io-500-dev/proposal-draft/mdtest
mkdir -p ${workdir}/ior_easy
lfs setstripe --stripe-count 2  ${workdir}/ior_easy
mkdir -p ${workdir}/ior_hard
lfs setstripe --stripe-count 100  ${workdir}/ior_hard
(
cd ..
echo "filesystem_utilization=$(df /mnt/lustre02)"
echo "date=$(date -I)"
echo "queue="
echo "nodes=$SLURM_NNODES"
echo "ppn=$SLURM_TASKS_PER_NODE"
echo "nodelist=$SLURM_NODELIST"
source io_500_core.sh
) 2>&1 | tee $SLURM_NNODES.txt
rm -rf $workdir/

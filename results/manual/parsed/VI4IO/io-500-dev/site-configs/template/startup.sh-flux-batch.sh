#!/bin/bash
#FLUX: --job-name=IO-500
#FLUX: -N=100
#FLUX: -t=10200
#FLUX: --urgency=16

mpirun="srun -m block"
mpirun_pfind=$mpirun
workdir= # directory where the data will be stored
output_dir= # the directory where the output will be kept
ior_easy_params="-t 2048k -b 122880000k" # 120 GBytes per process, file per proc is already configured
ior_hard_writes_per_proc=5000               # each process writes 5000 times 47k
mdtest_hard_files_per_proc=6000
mdtest_easy_files_per_proc=6000
params_mdreal="-P=5000 -I=1000"
subtree_to_scan_config=$PWD/subtree.cfg
processes_find=100 
( for I in $(seq $processes_find) ; do
  echo mdtest_tree.$I.0
done ) > subtree.cfg
find_cmd=$PWD/../../find/io500-find.sh
ior_cmd=/home/dkrz/k202079/work/io-500/io-500-dev/proposal-draft/ior
mdtest_cmd=/home/dkrz/k202079/work/io-500/io-500-dev/proposal-draft/mdtest
mdreal_cmd=
lines=`wc -l < subtree.cfg`
if [ $lines -le $SLURM_JOB_NUM_NODES ];
then
        mpirun_pfind=$mpirun" --ntasks-per-node=1"
fi
mkdir -p ${workdir}/ior_easy
lfs setstripe --stripe-count 2  ${workdir}/ior_easy
mkdir -p ${workdir}/ior_hard
lfs setstripe --stripe-count 100  ${workdir}/ior_hard
(
cd ../../ # walk to the directory with the io_500_core script
echo "filesystem_utilization=$(df /mnt/lustre02)"
echo "date=$(date -I)"
echo "queue="
echo "nodes=$SLURM_NNODES"
echo "ppn=$SLURM_TASKS_PER_NODE"
echo "nodelist=$SLURM_NODELIST"
source io_500_core.sh # Do not change the script
) 2>&1 | tee $SLURM_NNODES.txt
rm -rf $workdir/

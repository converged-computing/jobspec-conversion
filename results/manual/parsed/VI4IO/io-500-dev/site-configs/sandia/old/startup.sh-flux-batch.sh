#!/bin/bash
#FLUX: --job-name=IO-500
#FLUX: -N=16
#FLUX: -t=2400
#FLUX: --priority=16

filesys_root=/fscratch
basedir=${filesys_root}/gflofst
workdir=${basedir}/io500.`date +%Y.%m.%d-%H.%M.%S` # directory where the data will be stored
result_dir=${basedir}/results.`date +%Y.%m.%d-%H.%M.%S`  # the directory where the output will be kept
mkdir -p $workdir
mkdir -p $result_dir
mpirun="srun -m block --mpi=pmi2 "
mpirun_pfind=$mpirun
ior_cmd=${basedir}/ior
mdtest_cmd=${basedir}/mdtest
mdreal_cmd=${basedir}/md-real-io
find_cmd=${basedir}/io500-find.sh
ior_easy_params="-t 2048k -b 2g" # file per proc is already configured
ior_hard_writes_per_proc=60
mdtest_easy_files_per_proc=6100
mdtest_hard_files_per_proc=6100
ior_easy_params="-t 2048k -b 20g" # file per proc is already configured
ior_hard_writes_per_proc=7000     
mdtest_easy_files_per_proc=25000
mdtest_hard_files_per_proc=25000
mdreal_params="-P=5000 -I=1000"
find_subtree_to_scan_config=$PWD/find_subtree.cfg
processes_find=100 
( for I in $(seq $processes_find) ; do
  echo mdtest_tree.$I.0
done ) > find_subtree.cfg
lines=`wc -l < find_subtree.cfg`
if [ $lines -le $SLURM_JOB_NUM_NODES ];
then
        mpirun_pfind=$mpirun" --ntasks-per-node=1"
fi
mkdir -p ${workdir}/ior_easy
lfs setstripe --stripe-count 2  ${workdir}/ior_easy
mkdir -p ${workdir}/ior_hard
let "total_stripes = ${SLRUM_NNODES} * ${SLURM_TASKS_PER_NODE}"
lfs setstripe --stripe-count ${total_stripes} ${workdir}/ior_hard
(
echo Started at `date +%Y.%m.%d-%H.%M.%S`
echo "System: " `uname -n`
echo "filesystem_utilization=$(df ${filesys_root})"
echo "date=$(date -I)"
echo "nodes=$SLURM_NNODES"
echo "ppn=$SLURM_TASKS_PER_NODE"
echo "nodelist=$SLURM_NODELIST"
echo "workdir=$workdir"
echo "result_dir=$result_dir"
echo "filesys_root=$filesys_root"
echo "find_cmd=$find_cmd"
echo "ior_cmd=$ior_cmd"
echo "mdtest_cmd=$mdtest_cmd"
echo "mdreal_cmd=$mdreal_cmd"
echo "ior_easy_params=$ior_easy_params"
echo "ior_hard_writes_per_proc=$ior_hard_writes_per_proc"
echo "mdtest_easy_files_per_proc=$mdtest_easy_files_per_proc"
echo "mdtest_hard_files_per_proc=$mdtest_hard_files_per_proc"
echo "mdreal_params=$mdreal_params"
source io_500_core.sh # Do not change the script
) 2>&1 | tee io-500-summary.`date +%Y.%m.%d-%H.%M.%S`.txt
rmdir $workdir
rm -f find_subtree.cfg
echo Finished at `date +%Y.%m.%d-%H.%M.%S`

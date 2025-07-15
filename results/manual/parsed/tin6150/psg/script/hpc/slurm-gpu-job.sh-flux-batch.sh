#!/bin/bash
#FLUX: --job-name=SnGpuTest
#FLUX: --queue=savio4_gpu
#FLUX: -t=29999
#FLUX: --urgency=16

LOGDIR=/global/scratch/users/tin/JUNK/
MAQ=$(hostname)
TAG=$(hostname).$(date +%m%d.%H%M)
OUTFILE=$LOGDIR/slurm-gpu-job.$TAG.out.rst
hostname 
echo ----hostname-----------------------------------
echo -n "hostname: " 
hostname 
echo ----date-----------------------------------
date
echo ----os-release----------------------------------
cat /etc/os-release
echo ----lscpu-----------------------------------
lscpu
echo ----nvidia-smi-----------------------------------
nvidia-smi
echo "==== ================= ======================================================="
echo "==== gpu test next === =======================================================" 
echo "==== ================= ======================================================="
echo "---module list before purge ------------------------------------"
module list    2>&1
module purge   2>&1
module load ml/tensorflow/1.12.0-py36 2>&1 
echo "---module list after purge ------------------------------------"
module list    2>&1
PRECISION=fp32 
MODEL=inception3
BATCH_SIZE=32 # --num_batches param, this  should take about 8 hours
NUM_BATCHES=2500 # 1080ti n0299.sav2 ML@B, ~14 min to run
NUM_GPU=8
echo "---about to start tf cnn benchmark  --------------------"
echo time python /global/scratch/usrs/tin/gpu-benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py --model ${MODEL} --batch_size ${BATCH_SIZE} --num_batches ${NUM_BATCHES} --num_gpus ${NUM_GPU} --data_name imagenet 
date > /global/scratch/users/tin/JUNK/test-gpu.start.LOG.$MAQ 
date > /global/scratch/users/tin/JUNK/slurm-gpu-job.$TAG.begin
time python /global/home/users/tin/gpu-benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py --model ${MODEL} --batch_size ${BATCH_SIZE} --num_batches ${NUM_BATCHES} --num_gpus ${NUM_GPU} --data_name imagenet |tee /global/scratch/users/tin/JUNK/slurm-gpu-job.$TAG.log
echo ----date-----------------------------------
date | tee /global/scratch/users/tin/JUNK/test-gpu.end
date >     /global/scratch/users/tin/JUNK/slurm-gpu-job.$TAG.end
( 
echo '----what is shell inside () subshell?----'
echo $0
echo '---$0 inside () subshell is------'
echo $shell
) 2>&1 >> $OUTFILE   # append/capture the whole thing into a file name I prefer, slurm -o is too limitig
exit 0 

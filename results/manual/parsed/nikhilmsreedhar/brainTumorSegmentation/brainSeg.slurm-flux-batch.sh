#!/bin/bash
#FLUX: --job-name=tumor_seg
#FLUX: -c=8
#FLUX: -t=345600
#FLUX: --priority=16

export job_name='tumor_seg'
export log_dir='/home/cap5516.student10/job_logs/$job_name-$SLURM_JOB_ID'
export debug_logs='$log_dir/job_$SLURM_JOB_ID.log'
export benchmark_logs='$log_dir/job_$SLURM_JOB_ID.log'
export file=''
export args='-m torch.distributed.launch --nproc_per_node=2 --master_port 20003 train.py --experiment $SLURM_JOB_ID --batch_size 3 --end_epoch 400'
export python='/home/cap5516.student10/my-envs/cenv/bin/python'

export job_name="tumor_seg"
export log_dir="/home/cap5516.student10/job_logs/$job_name-$SLURM_JOB_ID"
mkdir $log_dir
export debug_logs="$log_dir/job_$SLURM_JOB_ID.log"
export benchmark_logs="$log_dir/job_$SLURM_JOB_ID.log"
module load anaconda/anaconda3
module load cuda/cuda-11.4
module load gcc/gcc-9.1.0
module load openmpi/openmpi-4.0.0-gcc-9.1.0
cd $SLURM_SUBMIT_DIR
echo "Slurm working directory: $SLURM_SUBMIT_DIR" >> $debug_logs
echo "JobID: $SLURM_JOB_ID" >> $debug_logs
echo "Running on $SLURM_NODELIST" >> $debug_logs
echo "Running on $SLURM_NNODES nodes." >> $debug_logs
echo "Running on $SLURM_NPROCS processors." >> $debug_logs
echo "Current working directory is `pwd`" >> $debug_logs
echo "Modules loaded:" >> $debug_logs
module list >> $debug_logs
echo "mpirun location: $(which mpirun)" >> $debug_logs
echo "Starting time: $(date)" >> $benchmark_logs
echo "ulimit -l: " >> $benchmark_logs
ulimit -l >> $benchmark_logs
export file=""
export args="-m torch.distributed.launch --nproc_per_node=2 --master_port 20003 train.py --experiment $SLURM_JOB_ID --batch_size 3 --end_epoch 400"
export python="/home/cap5516.student10/my-envs/cenv/bin/python"
nvidia-smi && time $python $file $args
sleep 3
echo "Ending time: $(date)" >> $benchmark_logs
echo "ulimit -l: " >> $benchmark_logs
ulimit -l >> $benchmark_logs
mv $job_name.$SLURM_JOB_ID.err $log_dir
mv $job_name.$SLURM_JOB_ID.out $log_dir

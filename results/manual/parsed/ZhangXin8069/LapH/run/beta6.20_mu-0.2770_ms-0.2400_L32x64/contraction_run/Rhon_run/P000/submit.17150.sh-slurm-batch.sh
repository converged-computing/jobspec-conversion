#!/bin/bash
#SBATCH --job-name=y_0_17150
#SBATCH --output=lap.14450.out
#SBATCH --error=lap.14450.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu-debug

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "17150 job starts at" `date` > $run_dir/output_17150.log
$exe $input_dir/input_17150 >> $run_dir/output_17150.log 2>&1
echo "17150 job ends at" `date` >> $run_dir/output_17150.log

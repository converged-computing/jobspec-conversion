#!/bin/bash
#SBATCH --job-name=y_0_13850
#SBATCH --output=lap.14450.out
#SBATCH --error=lap.14450.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "13850 job starts at" `date` > $run_dir/output_13850.log
$exe $input_dir/input_13850 >> $run_dir/output_13850.log 2>&1
echo "13850 job ends at" `date` >> $run_dir/output_13850.log

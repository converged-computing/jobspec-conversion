#!/bin/bash
#SBATCH --job-name=y_0_13500
#SBATCH --output=lap.14450.out
#SBATCH --error=lap.14450.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu-debug

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/corr_beta6.41_mu_0.2320_ms-0.2050_L32x64/contrac_meson_zero_ro.py    
echo "13500 job starts at" `date` > $run_dir/output_13500.log
$exe $input_dir/input_13500 >> $run_dir/output_13500.log 2>&1
echo "13500 job ends at" `date` >> $run_dir/output_13500.log

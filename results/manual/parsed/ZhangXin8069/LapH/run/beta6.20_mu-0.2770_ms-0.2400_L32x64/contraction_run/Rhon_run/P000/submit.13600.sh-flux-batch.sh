#!/bin/bash
#FLUX: --job-name=y_0_13600
#FLUX: --queue=gpu-debug
#FLUX: --priority=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "13600 job starts at" `date` > $run_dir/output_13600.log
$exe $input_dir/input_13600 >> $run_dir/output_13600.log 2>&1
echo "13600 job ends at" `date` >> $run_dir/output_13600.log

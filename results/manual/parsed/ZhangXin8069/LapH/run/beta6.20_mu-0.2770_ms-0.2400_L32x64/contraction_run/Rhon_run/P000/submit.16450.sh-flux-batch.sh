#!/bin/bash
#FLUX: --job-name=y_0_16450
#FLUX: --queue=gpu-debug
#FLUX: --priority=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "16450 job starts at" `date` > $run_dir/output_16450.log
$exe $input_dir/input_16450 >> $run_dir/output_16450.log 2>&1
echo "16450 job ends at" `date` >> $run_dir/output_16450.log

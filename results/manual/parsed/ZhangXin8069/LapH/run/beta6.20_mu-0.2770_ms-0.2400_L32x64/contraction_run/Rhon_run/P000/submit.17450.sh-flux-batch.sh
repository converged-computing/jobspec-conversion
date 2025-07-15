#!/bin/bash
#FLUX: --job-name=y_0_17450
#FLUX: --queue=gpu-debug
#FLUX: --priority=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "17450 job starts at" `date` > $run_dir/output_17450.log
$exe $input_dir/input_17450 >> $run_dir/output_17450.log 2>&1
echo "17450 job ends at" `date` >> $run_dir/output_17450.log

#!/bin/bash
#FLUX: --job-name=y_0_15950
#FLUX: --queue=gpu-debug
#FLUX: --priority=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "15950 job starts at" `date` > $run_dir/output_15950.log
$exe $input_dir/input_15950 >> $run_dir/output_15950.log 2>&1
echo "15950 job ends at" `date` >> $run_dir/output_15950.log

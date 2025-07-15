#!/bin/bash
#FLUX: --job-name=y_0_16300
#FLUX: --queue=gpu-debug
#FLUX: --priority=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "16300 job starts at" `date` > $run_dir/output_16300.log
$exe $input_dir/input_16300 >> $run_dir/output_16300.log 2>&1
echo "16300 job ends at" `date` >> $run_dir/output_16300.log

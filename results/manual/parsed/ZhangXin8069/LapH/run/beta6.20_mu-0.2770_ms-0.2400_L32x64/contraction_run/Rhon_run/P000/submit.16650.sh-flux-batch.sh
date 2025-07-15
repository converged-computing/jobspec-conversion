#!/bin/bash
#FLUX: --job-name=y_0_16650
#FLUX: --queue=gpu-debug
#FLUX: --priority=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "16650 job starts at" `date` > $run_dir/output_16650.log
$exe $input_dir/input_16650 >> $run_dir/output_16650.log 2>&1
echo "16650 job ends at" `date` >> $run_dir/output_16650.log

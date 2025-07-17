#!/bin/bash
#FLUX: --job-name=y_0_14200
#FLUX: --queue=gpu-debug
#FLUX: --urgency=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "14200 job starts at" `date` > $run_dir/output_14200.log
$exe $input_dir/input_14200 >> $run_dir/output_14200.log 2>&1
echo "14200 job ends at" `date` >> $run_dir/output_14200.log

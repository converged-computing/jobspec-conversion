#!/bin/bash
#FLUX: --job-name=y_0_17700
#FLUX: --queue=gpu-debug
#FLUX: --urgency=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "17700 job starts at" `date` > $run_dir/output_17700.log
$exe $input_dir/input_17700 >> $run_dir/output_17700.log 2>&1
echo "17700 job ends at" `date` >> $run_dir/output_17700.log

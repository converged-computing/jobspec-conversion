#!/bin/bash
#FLUX: --job-name=y_0_14950
#FLUX: --queue=gpu-debug
#FLUX: --priority=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "14950 job starts at" `date` > $run_dir/output_14950.log
$exe $input_dir/input_14950 >> $run_dir/output_14950.log 2>&1
echo "14950 job ends at" `date` >> $run_dir/output_14950.log

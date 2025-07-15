#!/bin/bash
#FLUX: --job-name=y_0_15350
#FLUX: --queue=gpu-debug
#FLUX: --priority=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "15350 job starts at" `date` > $run_dir/output_15350.log
$exe $input_dir/input_15350 >> $run_dir/output_15350.log 2>&1
echo "15350 job ends at" `date` >> $run_dir/output_15350.log

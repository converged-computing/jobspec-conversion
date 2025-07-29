#!/bin/bash
#FLUX: --job-name=y_0_14350
#FLUX: --queue=gpu-debug
#FLUX: --urgency=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "14350 job starts at" `date` > $run_dir/output_14350.log
$exe $input_dir/input_14350 >> $run_dir/output_14350.log 2>&1
echo "14350 job ends at" `date` >> $run_dir/output_14350.log

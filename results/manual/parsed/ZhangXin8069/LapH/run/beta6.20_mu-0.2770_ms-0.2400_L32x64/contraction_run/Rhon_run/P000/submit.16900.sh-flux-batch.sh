#!/bin/bash
#FLUX: --job-name=y_0_16900
#FLUX: --queue=gpu-debug
#FLUX: --urgency=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "16900 job starts at" `date` > $run_dir/output_16900.log
$exe $input_dir/input_16900 >> $run_dir/output_16900.log 2>&1
echo "16900 job ends at" `date` >> $run_dir/output_16900.log

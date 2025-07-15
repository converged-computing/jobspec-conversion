#!/bin/bash
#FLUX: --job-name=y_0_16800
#FLUX: --queue=gpu-debug
#FLUX: --urgency=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "16800 job starts at" `date` > $run_dir/output_16800.log
$exe $input_dir/input_16800 >> $run_dir/output_16800.log 2>&1
echo "16800 job ends at" `date` >> $run_dir/output_16800.log

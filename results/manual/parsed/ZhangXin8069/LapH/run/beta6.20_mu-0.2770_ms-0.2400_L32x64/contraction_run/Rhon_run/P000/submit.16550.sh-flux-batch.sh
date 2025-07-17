#!/bin/bash
#FLUX: --job-name=y_0_16550
#FLUX: --queue=gpu-debug
#FLUX: --urgency=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "16550 job starts at" `date` > $run_dir/output_16550.log
$exe $input_dir/input_16550 >> $run_dir/output_16550.log 2>&1
echo "16550 job ends at" `date` >> $run_dir/output_16550.log

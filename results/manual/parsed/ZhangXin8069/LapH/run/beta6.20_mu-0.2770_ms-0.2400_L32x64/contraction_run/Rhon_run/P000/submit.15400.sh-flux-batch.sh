#!/bin/bash
#FLUX: --job-name=y_0_15400
#FLUX: --queue=gpu-debug
#FLUX: --urgency=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "15400 job starts at" `date` > $run_dir/output_15400.log
$exe $input_dir/input_15400 >> $run_dir/output_15400.log 2>&1
echo "15400 job ends at" `date` >> $run_dir/output_15400.log

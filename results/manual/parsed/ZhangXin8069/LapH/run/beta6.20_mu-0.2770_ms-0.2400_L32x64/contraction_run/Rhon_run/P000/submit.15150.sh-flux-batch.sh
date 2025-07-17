#!/bin/bash
#FLUX: --job-name=y_0_15150
#FLUX: --queue=gpu-debug
#FLUX: --urgency=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/contrac_meson_zero_ro.py    
echo "15150 job starts at" `date` > $run_dir/output_15150.log
$exe $input_dir/input_15150 >> $run_dir/output_15150.log 2>&1
echo "15150 job ends at" `date` >> $run_dir/output_15150.log

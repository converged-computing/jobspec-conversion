#!/bin/bash
#FLUX: --job-name=y_0_17000
#FLUX: --queue=gpu-debug
#FLUX: --urgency=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/corr_beta6.41_mu_0.2320_ms-0.2050_L32x64/contrac_meson_zero_ro.py    
echo "17000 job starts at" `date` > $run_dir/output_17000.log
$exe $input_dir/input_17000 >> $run_dir/output_17000.log 2>&1
echo "17000 job ends at" `date` >> $run_dir/output_17000.log

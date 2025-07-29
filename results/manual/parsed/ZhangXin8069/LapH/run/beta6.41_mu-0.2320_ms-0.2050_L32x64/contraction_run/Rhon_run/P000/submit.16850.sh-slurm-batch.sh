#!/bin/bash
#FLUX: --job-name=y_0_16850
#FLUX: --queue=gpu-debug
#FLUX: --urgency=16

run_dir=.
input_dir=${run_dir}
exe=/beegfs/home/zhangxin/content/LapH/contraction_code/corr_beta6.41_mu_0.2320_ms-0.2050_L32x64/contrac_meson_zero_ro.py    
echo "16850 job starts at" `date` > $run_dir/output_16850.log
$exe $input_dir/input_16850 >> $run_dir/output_16850.log 2>&1
echo "16850 job ends at" `date` >> $run_dir/output_16850.log

#!/bin/bash
#FLUX: --job-name=avg
#FLUX: -c=6
#FLUX: --queue=batch
#FLUX: -t=1800
#FLUX: --urgency=16

module load pytorch/1.2.0-cuda10.0-cudnn7.6-py3.7
frac_values=( 0.1 )
bs_values=( 100 )
lr_values=( 1e-2 )
out_dim_values=( 1 )
type_values=( 'sms' 'call' 'net')
file_values=( 'milano.h5' 'trento.h5')
trial=${SLURM_ARRAY_TASK_ID}
frac=${frac_values[$(( trial % ${#frac_values[@]} ))]}
trial=$(( trial / ${#frac_values[@]} ))
bs=${bs_values[$(( trial % ${#bs_values[@]} ))]}
trial=$(( trial / ${#bs_values[@]} ))
lr=${lr_values[$(( trial % ${#lr_values[@]} ))]}
trial=$(( trial / ${#lr_values[@]} ))
out_dim=${out_dim_values[$(( trial % ${#out_dim_values[@]} ))]}
trial=$(( trial / ${#out_dim_values[@]} ))
type=${type_values[$(( trial % ${#type_values[@]} ))]}
trial=$(( trial / ${#type_values[@]} ))
file=${file_values[$(( trial % ${#file_values[@]} ))]}
python fed_avg_algo.py --file ${file} --type ${type} --lr ${lr} --frac ${frac} --bs ${bs} --opt 'sgd' --out_dim ${out_dim}

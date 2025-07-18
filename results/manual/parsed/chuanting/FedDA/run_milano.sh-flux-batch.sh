#!/bin/bash
#FLUX: --job-name=sms_call
#FLUX: -c=6
#FLUX: --queue=batch
#FLUX: -t=7200
#FLUX: --urgency=16

module load pytorch/1.2.0-cuda10.0-cudnn7.6-py3.7
cluster_values=( 16 )
frac_values=( 0.1 )
bs_values=( 100 )
lb_values=( 20 )
le_values=( 1 )
lr_values=( 1e-2 )
w_lr_values=( 1e-1 )
out_dim_values=( 1 )
rho_values=( -0.3 -0.2 -0.1 0 0.1 0.2 0.3  )
type_values=( 'sms' 'call' )
file_values=( 'milano.h5')
trial=${SLURM_ARRAY_TASK_ID}
cluster=${cluster_values[$(( trial % ${#cluster_values[@]} ))]}
trial=$(( trial / ${#cluster_values[@]} ))
frac=${frac_values[$(( trial % ${#frac_values[@]} ))]}
trial=$(( trial / ${#frac_values[@]} ))
bs=${bs_values[$(( trial % ${#bs_values[@]} ))]}
trial=$(( trial / ${#bs_values[@]} ))
lr=${lr_values[$(( trial % ${#lr_values[@]} ))]}
trial=$(( trial / ${#lr_values[@]} ))
w_lr=${w_lr_values[$(( trial % ${#w_lr_values[@]} ))]}
trial=$(( trial / ${#w_lr_values[@]} ))
lb=${lb_values[$(( trial % ${#lb_values[@]} ))]}
trial=$(( trial / ${#lb_values[@]} ))
le=${le_values[$(( trial % ${#le_values[@]} ))]}
trial=$(( trial / ${#le_values[@]} ))
out=${out_dim_values[$(( trial % ${#out_dim_values[@]} ))]}
trial=$(( trial / ${#out_dim_values[@]} ))
rho=${rho_values[$(( trial % ${#rho_values[@]} ))]}
trial=$(( trial / ${#rho_values[@]} ))
type=${type_values[$(( trial % ${#type_values[@]} ))]}
trial=$(( trial / ${#type_values[@]} ))
file=${file_values[$(( trial % ${#file_values[@]} ))]}
python fed_dual_att.py --file ${file} --type ${type} --bs ${bs} --frac ${frac} --cluster ${cluster} --lr ${lr} --w_lr ${w_lr} --opt 'sgd' --rho ${rho}

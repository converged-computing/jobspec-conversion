#!/bin/bash
#FLUX: --job-name=var
#FLUX: --queue=owners,horence,quake
#FLUX: -t=21600
#FLUX: --urgency=16

date
DATANAME="Tabula_muris_senis_P2_10x_with_postprocessing_cellann"
SUB="tissue"
GROUP="compartment"
a="python3.6 -u /scratch/PI/horence/JuliaO/single_cell/SZS_pipeline2/scripts/variance_adjusted_permutations_bytiss.py --group_col ${GROUP} --suffix _S_0.1_z_0.0_b_5 --dataname ${DATANAME} --num_perms 100 --sub_col ${SUB}"
echo $a 
eval $a
date

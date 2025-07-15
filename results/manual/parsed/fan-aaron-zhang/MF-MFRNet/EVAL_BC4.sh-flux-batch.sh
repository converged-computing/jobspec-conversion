#!/bin/bash
#FLUX: --job-name=noHDRBD_VTM162
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

module add languages/anaconda3/2019.07-3.6.5-tflow-1.14
module add apps/matlab/2018a
which python
echo "Decoding start!"
scriptPath='/user/home/hw22082/VTM16.2_HDR_EBDA/MFRNet/'
hostDecoder='VTM1620_Decoder'
streamPath='/user/work/hw22082/JVET9bit/STREAM/'
yuvPath='/user/work/hw22082/JVET9bit/REC/'
statPath='/user/work/hw22082/JVET9bit/STAT/'
logPath='/user/work/hw22082/JVET9bit/'
origPath='/user/work/hw22082/Sequence_HDR/JVET_HDR_10bit/'
echo "Decode: sequence #${SLURM_ARRAY_TASK_ID} on NODEID: #${SLURM_NODEID}"
echo "SLURM_NODE_ALIASES: #${SLURM_NODE_ALIASES}"
time matlab -r "addpath(genpath('$scriptPath')); mainDec_EVAL('${scriptPath}','${hostDecoder}','${streamPath}','${yuvPath}','${origPath}','${statPath}',$SLURM_ARRAY_TASK_ID); exit;"

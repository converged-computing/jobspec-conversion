#!/bin/bash
#FLUX: --job-name=purity_07
#FLUX: -c=16
#FLUX: --queue=dept_gpu
#FLUX: --priority=16

echo
echo $SLURM_JOB_NODELIST
echo
user=$(whoami)
job_dir=${user}_${SLURM_JOB_NAME}_${SLURM_JOB_ID}.dcb.private.net
mkdir /scr/$job_dir
cd /scr/$job_dir
script_dir=/net/capricorn/home/xing/tch42/Projects/a549_pcna/src/1_preprocess
tools_dir=/net/capricorn/home/xing/tch42/Projects/a549_pcna/src/3-compute/tools
dat_dir=/net/capricorn/home/xing/tch42/Projects/a549_pcna/data
train_path=${dat_dir}/train/reg/patch/purity_thres_40
wts_path=${dat_dir}/wts/reg
echo ${train_path}
rsync -ra ${script_dir}/* .
rsync -ra ${tools_dir}/* .
module load anaconda/3-cluster
module load cuda/11.1
eval "$(conda shell.bash hook)"
source activate tf1
train_input_path=${train_path}/img
train_gt_path=${train_path}/interior
wts_file=a549_reg_pt40_nextgen.hdf5
mkdir -p wts_path
echo ${wts_file}
python 2_train_reg_wts.py $train_input_path $train_gt_path $wts_path $wts_file

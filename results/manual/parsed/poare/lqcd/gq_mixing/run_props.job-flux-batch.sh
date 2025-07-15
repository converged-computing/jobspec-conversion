#!/bin/bash
#FLUX: --job-name=prop_gen
#FLUX: --queue=prod
#FLUX: --urgency=16

export OMP_NUM_THREADS='6'

set -x
cd /home/lqcd/poare/lqcd/mosaic
bash
module load openmpi/3.1.5
module load qlua/20200107-gpu1080
EXE=qlua
cfgpath="/work/lqcd/d10b/ensembles/isoClover/"
cfgbase="cl21_12_24_b6p1_m0p2800m0p2450"
gpu=true
stream="-d"
home=/home/lqcd/poare/lqcd/gq_mixing
logs=${home}/logs/${cfgbase}_${SLURM_JOB_ID}
output=/work/lqcd/d10b/users/poare/gq_mixing/props/${cfgbase}_${SLURM_JOB_ID}
mkdir ${logs}
mkdir ${logs}/no_output
mkdir ${output}
parameters="jobid = ${SLURM_JOB_ID} cfgpath = '${cfgpath}' cfgbase = '${cfgbase}' gpu=${gpu} stream=${stream}"
export OMP_NUM_THREADS=6
mpirun -np 4 $EXE -e "$parameters" ${home}/prop_generation.qlua > ${logs}/log_${SLURM_JOB_ID}.txt

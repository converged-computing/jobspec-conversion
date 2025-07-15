#!/bin/bash
#FLUX: --job-name=vector_op_npr_2
#FLUX: --queue=a100r
#FLUX: --priority=16

export OMP_NUM_THREADS='6'

cfg=$1
JOB_ID=$2
set -x
cd /home/lqcd/poare/lqcd/mosaic
bash
module load slurm/19.05.4.1
module load gcc/7.5.0
module load qlua/20201002
module load openmpi/3.1.5
gpu=false
EXE=qlua
cfgpath="/work/lqcd/d20b/ensembles/isoClover/"
cfgbase="cl3_32_48_b6p1_m0p2450"
home=/home/lqcd/poare/lqcd/0nubb/vector_ops
logs=${home}/logs/${cfgbase}_${JOB_ID}
output=/work/lqcd/d20b/users/poare/0nubb/vector_ops/meas/${cfgbase}_${JOB_ID}
parameters="jobid = ${JOB_ID} cfgpath = '${cfgpath}' cfgbase = '${cfgbase}' gpu=${gpu}"
export OMP_NUM_THREADS=6
mpirun -np 4 $EXE -e "$parameters cfgnum = ${cfg}" ${home}/vector_ops2.qlua > ${logs}/cfg${cfg}_2.txt

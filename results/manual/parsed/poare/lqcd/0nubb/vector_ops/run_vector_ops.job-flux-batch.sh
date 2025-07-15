#!/bin/bash
#FLUX: --job-name=vector_op_npr
#FLUX: --queue=a100r
#FLUX: --urgency=16

export OMP_NUM_THREADS='6'

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
logs=${home}/logs/${cfgbase}_${SLURM_JOB_ID}
output=/work/lqcd/d20b/users/poare/0nubb/vector_ops/meas/${cfgbase}_${SLURM_JOB_ID}
mkdir ${logs}
mkdir ${logs}/no_output
mkdir ${output}
parameters="jobid = ${SLURM_JOB_ID} cfgpath = '${cfgpath}' cfgbase = '${cfgbase}' gpu=${gpu}"
export OMP_NUM_THREADS=6
cfg=1230
	#srun --mpi=pmix --ntasks=4 $EXE -e "$parameters cfgnum = ${cfg}" ${home}/vector_ops.qlua > ${logs}/cfg${cfg}.txt
	mpirun -np 4 $EXE -e "$parameters cfgnum = ${cfg}" ${home}/vector_ops.qlua > ${logs}/cfg${cfg}.txt

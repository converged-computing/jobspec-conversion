#!/bin/bash
#FLUX: --job-name=gq_mixing
#FLUX: --queue=a100l
#FLUX: --urgency=16

export OMP_NUM_THREADS='6'

set -x
cd /home/lqcd/poare/lqcd/mosaic
bash
module load PrgEnv-Wombat
module load PrgEnv-Qlua
module load slurm/19.05.4.1
EXE=qlua
cfgpath="/work/lqcd/d20b/ensembles/isoClover/cl3_16_48_b6p1_m0p2450/"
cfgbase="cl3_16_48_b6p1_m0p2450"
home=/home/lqcd/poare/lqcd/gq_mixing
logs=${home}/logs/girs_${cfgbase}_${SLURM_JOB_ID}
output=/work/lqcd/d20b/users/poare/gq_mixing/girs/${cfgbase}_${SLURM_JOB_ID}
mkdir ${logs}
mkdir ${logs}/no_output
mkdir ${output}
parameters="jobid = ${SLURM_JOB_ID} cfgpath = '${cfgpath}' cfgbase = '${cfgbase}'"
export OMP_NUM_THREADS=6
cfg=1600
	# mpirun -np 4 $EXE -e "$parameters cfgnum = ${cfg}" ${home}/girs.qlua > ${logs}/cfg${cfg}.txt
    srun --mpi=pmix --ntasks=4 $EXE -e "$parameters cfgnum = ${cfg}" ${home}/girs.qlua > ${logs}/cfg${cfg}.txt

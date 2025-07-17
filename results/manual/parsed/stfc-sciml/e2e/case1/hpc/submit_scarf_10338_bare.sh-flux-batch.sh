#!/bin/bash
#FLUX: --job-name=confused-latke-9043
#FLUX: --exclusive
#FLUX: --queue=scarf
#FLUX: -t=345600
#FLUX: --urgency=16

export BASE_DIR='/home/vol08/scarf688/git/intel-e2e-benchmark/case1'
export RELION_IMG='$BASE_DIR/relion.sif'
export RELION_PROJ_DIR='/work3/projects/sciml/scarf688/relion/10338'
export RELION_OUTPUT_DIR='/work3/projects/sciml/scarf688/relion/runs/scarf/job_$SLURM_JOB_ID'
export PATH='$BASE_DIR/relion/build/bin:$PATH'
export RELION_CMD=''
export RELION_NUM_CPUS='${SLURM_NTASKS:-23}'
export RELION_CPU_THREADS_PER_TASK='4'
export RELION_OPT_FLAGS='--dont_combine_weights_via_disc --cpu --pool $RELION_NUM_CPUS --j $RELION_CPU_THREADS_PER_TASK'
export RELION_MPI_FLAGS=''

module load intel/2019b
export BASE_DIR="/home/vol08/scarf688/git/intel-e2e-benchmark/case1"
export RELION_IMG="$BASE_DIR/relion.sif"
export RELION_PROJ_DIR="/work3/projects/sciml/scarf688/relion/10338"
export RELION_OUTPUT_DIR="/work3/projects/sciml/scarf688/relion/runs/scarf/job_$SLURM_JOB_ID"
export PATH="$BASE_DIR/relion/build/bin:$PATH"
export RELION_CMD=""
export RELION_NUM_CPUS=${SLURM_NTASKS:-23}
export RELION_CPU_THREADS_PER_TASK=4
export RELION_OPT_FLAGS="--dont_combine_weights_via_disc --cpu --pool $RELION_NUM_CPUS --j $RELION_CPU_THREADS_PER_TASK"
export RELION_MPI_FLAGS=''
./benchmark_scripts/benchmark_relion.py $RELION_SCRIPT_NAME

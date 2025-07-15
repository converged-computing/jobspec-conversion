#!/bin/bash
#FLUX: --job-name=buttery-nunchucks-2727
#FLUX: -c=2
#FLUX: --priority=16

export BASE_DIR='/mnt/beegfs/work/stfc/pearl008/intel-e2e-benchmark/case1'
export RELION_IMG='$BASE_DIR/relion.sif'
export RELION_PROJ_DIR='$BASE_DIR/data/10338'
export RELION_OUTPUT_DIR='$BASE_DIR/runs/pearl/job_$SLURM_JOB_ID'
export RELION_CMD='singularity run --nv -B $BASE_DIR -H $RELION_PROJ_DIR $RELION_IMG -gpu_check_disable'
export RELION_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'
export RELION_OPT_FLAGS='--gpu --dont_combine_weights_via_disc --pool 30'

module load OpenMPI/4.1.0-GCC-9.3.0
export BASE_DIR="/mnt/beegfs/work/stfc/pearl008/intel-e2e-benchmark/case1"
export RELION_IMG="$BASE_DIR/relion.sif"
export RELION_PROJ_DIR="$BASE_DIR/data/10338"
export RELION_OUTPUT_DIR="$BASE_DIR/runs/pearl/job_$SLURM_JOB_ID"
export RELION_CMD="singularity run --nv -B $BASE_DIR -H $RELION_PROJ_DIR $RELION_IMG -gpu_check_disable"
export RELION_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
export RELION_OPT_FLAGS='--gpu --dont_combine_weights_via_disc --pool 30'
./benchmark_scripts/benchmark_relion.py ./benchmark_scripts/10338/pipeline_class3d_1.sh

#!/bin/bash
#FLUX: --job-name=stanky-kerfuffle-1356
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: -t=345600
#FLUX: --urgency=16

export BASE_DIR='/home/vol08/scarf688/git/intel-e2e-benchmark/case1'
export RELION_IMG='$BASE_DIR/relion.sif'
export RELION_PROJ_DIR='/work3/projects/sciml/scarf688/relion/relion_benchmark'
export RELION_OUTPUT_DIR='/work3/projects/sciml/scarf688/relion/runs/scarf/job_$SLURM_JOB_ID'
export RELION_CMD='singularity run -B $RELION_OUTPUT_DIR -B $BASE_DIR -H $RELION_PROJ_DIR $RELION_IMG -gpu_disable_check'
export RELION_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'
export RELION_OPT_FLAGS='--dont_combine_weights_via_disc --pool 30'
export RELION_MPI_FLAGS='--mca opal_warn_on_missing_libcuda 0'

module load OpenMPI/4.1.0-iccifort-2018.3.222-GCC-7.3.0-2.30
export BASE_DIR="/home/vol08/scarf688/git/intel-e2e-benchmark/case1"
export RELION_IMG="$BASE_DIR/relion.sif"
export RELION_PROJ_DIR="/work3/projects/sciml/scarf688/relion/relion_benchmark"
export RELION_OUTPUT_DIR="/work3/projects/sciml/scarf688/relion/runs/scarf/job_$SLURM_JOB_ID"
export RELION_CMD="singularity run -B $RELION_OUTPUT_DIR -B $BASE_DIR -H $RELION_PROJ_DIR $RELION_IMG -gpu_disable_check"
export RELION_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
export RELION_OPT_FLAGS='--dont_combine_weights_via_disc --pool 30'
export RELION_MPI_FLAGS='--mca opal_warn_on_missing_libcuda 0'
./benchmark_scripts/benchmark_relion.py ./benchmark_scripts/plasmodium_ribosome_benchmarks.sh 

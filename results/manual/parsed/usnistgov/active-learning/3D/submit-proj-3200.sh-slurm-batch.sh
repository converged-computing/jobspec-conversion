#!/bin/bash
#FLUX: --job-name=job_2023-10-31_proj-3200_v000
#FLUX: -c=10
#FLUX: --queue=rack1
#FLUX: -t=345600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$omp_threads'
export OPENBLAS_NUM_THREADS='$omp_threads'
export MKL_NUM_THREADS='$omp_threads'
export VECLIB_MAXIMUM_THREADS='$omp_threads'
export NUMEXPR_NUM_THREADS='$omp_threads'

omp_threads=$SLURM_CPUS_PER_TASK
export OMP_NUM_THREADS=$omp_threads
export OPENBLAS_NUM_THREADS=$omp_threads
export MKL_NUM_THREADS=$omp_threads
export VECLIB_MAXIMUM_THREADS=$omp_threads
export NUMEXPR_NUM_THREADS=$omp_threads
job_name="job_2023-10-31_proj-3200_v000"
reason="Sliced Wasserstein with 3200 projects"
nu=1.5
cutoff=20
scoring="mae"
ylog=true
n_query=1600
n_projections=3200
slurm_id=${SLURM_JOB_ID}
~/bin/nix-root nix develop ../ --command bash -c "snakemake \
  --nolock \
  --cores 10 \
  --config \
  job_name=$job_name \
  n_iterations=20 \
  n_projections=$n_projections \
  n_query=$n_query \
  nu=$nu \
  scoring=$scoring \
  cutoff=$cutoff \
  ylog=$ylog \
  reason=\"$reason\" \
  slurm_id=$slurm_id \
"

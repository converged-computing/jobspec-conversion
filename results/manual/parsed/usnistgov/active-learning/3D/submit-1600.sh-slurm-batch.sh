#!/bin/bash
#SBATCH --job-name=job_2023-10-12_query-1600_v000
#SBATCH --output=log/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0G
#SBATCH --time=5-00:00:00
#SBATCH --qos=test
#SBATCH --chdir=/working/wd15/active-learning/3D

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
job_name="job_2023-10-12_query-1600_v000"
reason="1600 queries"
nu=1.5
cutoff=20
scoring="mae"
ylog=0
n_query=1600
slurm_id=${SLURM_JOB_ID}
n_projections=50
~/bin/nix-root nix develop ../ --command bash -c "snakemake \
  --nolock \
  --cores 10 \
  --config \
  job_name=$job_name \
  n_iterations=20 \
  n_query=$n_query \
  nu=$nu \
  scoring=$scoring \
  cutoff=$cutoff \
  ylog=$ylog \
  reason=\"$reason\" \
  slurm_id=$slurm_id \
  n_projections=$n_projections \
"

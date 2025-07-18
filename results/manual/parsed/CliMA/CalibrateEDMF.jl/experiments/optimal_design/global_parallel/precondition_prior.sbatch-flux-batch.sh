#!/bin/bash
#FLUX: --job-name=precond
#FLUX: -t=7200
#FLUX: --urgency=16

module load julia/1.10.1
iteration_=${1?Error: no iteration given}
job_id=${2?Error: no job ID given}
run_num=${SLURM_ARRAY_TASK_ID}
job_dir=$(head $job_id".txt" | tail -1)
version=$(head -"$run_num" $job_dir/"versions_"$iteration_".txt" | tail -1)
julia --project -C skylake-avx512 -JCEDMF.so precondition_prior.jl --version $version --job_dir $job_dir && (
  echo sysimage loaded successfully
) || (
  julia --project precondition_prior.jl --version $version --job_dir $job_dir
)
echo "Preconditioning for ${version} finished."

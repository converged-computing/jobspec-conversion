#!/bin/bash
#FLUX: --job-name=doopy-parsnip-0834
#FLUX: -t=14400
#FLUX: --urgency=16

export MODULEPATH='/groups/esm/modules:$MODULEPATH'
export JULIA_NUM_THREADS='${SLURM_CPUS_PER_TASK:=1}'
export JULIA_MPI_BINARY='system'
export JULIA_CUDA_USE_BINARYBUILDER='false'
export CLIMACOMMS_DEVICE='CPU'

export MODULEPATH="/groups/esm/modules:$MODULEPATH"
config_rel=${1?Error: no config file given}
config=$(realpath $config_rel)
job_id=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')
n=$(grep N_ens ${config} | cut -d=   -f2 | cut -d#   -f1 | xargs)
n_it=$(grep N_iter ${config} | cut -d=   -f2 | cut -d#   -f1 | xargs)
echo "Initializing calibration with ${n} ensemble members and ${n_it} iterations."
module purge
module load julia/1.10.3
export JULIA_NUM_THREADS=${SLURM_CPUS_PER_TASK:=1}
export JULIA_MPI_BINARY=system
export JULIA_CUDA_USE_BINARYBUILDER=false
export CLIMACOMMS_DEVICE=CPU
julia --project -e 'using Pkg; Pkg.instantiate(); Pkg.build()'
julia --project -e 'using Pkg; Pkg.precompile()'
for it in $(seq 1 1 $n_it)
do
if [ "$it" = "1" ]; then
    # Initialize calibration
    id_init_ens=$(sbatch --parsable --kill-on-invalid-dep=yes -A esm -p expansion init.sbatch $config $job_id)
    # Precondition parameters
    id_precond=$(sbatch --parsable --kill-on-invalid-dep=yes -A esm -p expansion --dependency=afterok:$id_init_ens --array=1-$n precondition_prior.sbatch $it $job_id)
    # Run ensemble of forward models
    id_ens_array=$(sbatch --parsable --kill-on-invalid-dep=yes -A esm -p expansion --dependency=afterok:$id_precond --array=1-$n single_scm_eval.sbatch $it $job_id)
else
    id_ens_array=$(sbatch --parsable --kill-on-invalid-dep=yes -A esm -p expansion --dependency=afterok:$id_ek_upd --array=1-$n single_scm_eval.sbatch $it $job_id)
fi
id_ek_upd=$(sbatch --parsable --kill-on-invalid-dep=yes -A esm -p expansion --dependency=afterok:$id_ens_array --export=n=$n step_ekp.sbatch $it $job_id)
done

#!/bin/bash
#FLUX: --job-name=ekp_call
#FLUX: -t=3600
#FLUX: --urgency=16

export JULIA_NUM_THREADS='${SLURM_CPUS_PER_TASK:=1}'
export JULIA_MPI_BINARY='system'
export JULIA_CUDA_USE_BINARYBUILDER='false'

n=10
n_it=5
module purge
module load julia/1.5.2 hdf5/1.10.1 netcdf-c/4.6.1 openmpi/4.0.1
export JULIA_NUM_THREADS=${SLURM_CPUS_PER_TASK:=1}
export JULIA_MPI_BINARY=system
export JULIA_CUDA_USE_BINARYBUILDER=false
julia --project -e 'using Pkg; Pkg.instantiate(); Pkg.build()'
julia --project -e 'using Pkg; Pkg.precompile()'
id_init_ens=$(sbatch --parsable -A esm ekp_init_calibration.sbatch)
for it in $(seq 1 1 $n_it)
do
if [ "$it" = "1" ]; then
    id_ens_array=$(sbatch --parsable --kill-on-invalid-dep=yes -A esm --dependency=afterok:$id_init_ens --array=1-$n ekp_single_cm_run.sbatch $it)
else
    id_ens_array=$(sbatch --parsable --kill-on-invalid-dep=yes -A esm --dependency=afterok:$id_ek_upd --array=1-$n ekp_single_cm_run.sbatch $it)
fi
id_ek_upd=$(sbatch --parsable --kill-on-invalid-dep=yes -A esm --dependency=afterok:$id_ens_array --export=n=$n ekp_cont_calibration.sbatch $it)
done

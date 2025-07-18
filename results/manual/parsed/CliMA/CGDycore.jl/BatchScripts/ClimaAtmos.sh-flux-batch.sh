#!/bin/bash
#FLUX: --job-name=30-3-10
#FLUX: -n=64
#FLUX: -t=86400
#FLUX: --urgency=16

export JULIA_NUM_THREADS='${SLURM_CPUS_PER_TASK:=1}'
export CLIMACORE_DISTRIBUTED='MPI'
export JULIA_HDF5_PATH=''
export PMIX_MCA_gds='hash'

module purge
module load julia/1.8.2 openmpi/4.1.1 hdf5/1.12.1-ompi411
export JULIA_NUM_THREADS=${SLURM_CPUS_PER_TASK:=1}
export CLIMACORE_DISTRIBUTED="MPI"
export JULIA_HDF5_PATH=""
export PMIX_MCA_gds=hash
CA_EXAMPLE=$HOME'/Documents/ClimaAtmos.jl/examples/'
DRIVER=$CA_EXAMPLE'hybrid/driver.jl'
OUTPUT_DIR='/central/groups/esm/jiahe/ClimaAtmos/dry_baro_wave/'
julia --project=$CA_EXAMPLE -e 'using Pkg; Pkg.instantiate()'
julia --project=$CA_EXAMPLE -e 'using Pkg; Pkg.build("HDF5")'
julia --project=$CA_EXAMPLE -e 'using Pkg; Pkg.add("MPIPreferences"); using MPIPreferences; use_system_binary()'
julia --project=$CA_EXAMPLE -e 'using Pkg; Pkg.build("MPI")'
julia --project=$CA_EXAMPLE -e 'using Pkg; Pkg.API.precompile()'
mpiexec julia --project=$CA_EXAMPLE $DRIVER --output_dir $OUTPUT_DIR --z_elem 45 --dz_bottom 30 --h_elem 16 --kappa_4 1e16 --dt 200secs --t_end 1days --dt_save_to_disk 1hours

#!/bin/bash
#FLUX: --job-name=epoch
#FLUX: --queue=nodes
#FLUX: -t=60
#FLUX: --urgency=16

method="Singularity"
output_dir="."
dims="2"
photons=""
run_epoch="./run_epoch.py"
epoch_exe="./bin/epoch2d"
mpi_module="OpenMPI"
module purge
module load ${mpi_module}
if [[ ${method} -eq "Singularity" ]]; then
  module load Python Apptainer
  # Suppress warnings
  export PMIX_MCA_gds=^ds12
  export PMIX_MCA_psec=^munge
  # Fix intra-node communication issue
  # https://ciq.com/blog/workaround-for-communication-issue-with-mpi-apps-apptainer-without-setuid/
  export OMPI_MCA_pml=ucx
  export OMPI_MCA_btl='^vader,tcp,openib,uct'
  export UCX_TLS=^'posix,cma'
  echo "Running Epoch with Apptainer using ${SLURM_NTASKS} processes"
  python ${run_epoch} singularity -d ${dims} -o ${output_dir} ${photons} --srun
  # Alternative in case the above isn't working:
  # srun singularity exec --bind ${output_dir}:/output oras://ghcr.io/plasmafair/epoch.sif:latest run_epoch -d ${dims} -o /output --srun ${photons}
elif [[ ${method} -eq "Source" ]]; then
  echo "Running Epoch from source using ${SLURM_NTASKS} processes"
  echo ${output_dir} | srun ${epoch_exe}
else
  echo "Set method to one of 'Singularity' or 'Source'" 1>&2
  exit 1
fi

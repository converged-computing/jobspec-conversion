#!/bin/bash
#SBATCH --job-name=epoch
#SBATCH --account=ACCOUNT_CODE
#SBATCH --output=%x_%j.log
#SBATCH --mail-user=abc123@york.ac.uk
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --time=00:01:00
#SBATCH --partition=nodes
#SBATCH --constraint=ntasks-per-node=2

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

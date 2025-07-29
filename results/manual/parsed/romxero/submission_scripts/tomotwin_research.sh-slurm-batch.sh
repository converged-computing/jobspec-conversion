#!/bin/bash
#SBATCH --job-name=tomotwin_lbann_integration_research
#SBATCH --output=tomotwin_lbann_integration_research_%A.%a.out
#SBATCH --error=tomotwin_lbann_integration_research_%A.%a.err
#SBATCH --mail-user=randall.white@czbiohub.org
#SBATCH --mail-type=START,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=2G
#SBATCH --time=04:10:00

SPACK_ENV_NAME="LBANN_experiment"
ml purge
ml mamba
git clone -c feature.manyFiles=true https://github.com/spack/spack.git
source spack/share/spack/setup-env.sh
spack install -j ${SLURM_CPUS_PER_TASK} lbann
spack install -j ${SLURM_CPUS_PER_TASK} anaconda3
spack install -j ${SLURM_CPUS_PER_TASK} python@3.11.7
spack load lbann
spack load anaconda3@2023.09-0
mamba env create --prefix=/hpc/mydata/randall.white/lbann_research/tomotwin_env -f https://raw.githubusercontent.com/MPI-Dortmund/tomotwin-cryoet/main/conda_env_tomotwin.yml
mamba env create --prefix=/hpc/mydata/randall.white/lbann_research/napari_tomotwin_env -f https://raw.githubusercontent.com/MPI-Dortmund/napari-tomotwin/main/conda_env.yml
exit 0

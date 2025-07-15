#!/bin/bash
#FLUX: --job-name=butterscotch-mango-0372
#FLUX: -t=15000
#FLUX: --urgency=16

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

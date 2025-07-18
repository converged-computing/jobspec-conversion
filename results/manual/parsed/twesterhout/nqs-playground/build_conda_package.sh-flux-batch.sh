#!/bin/bash
#FLUX: --job-name=fugly-general-6892
#FLUX: -c=16
#FLUX: --queue=gpu_short
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH='/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/CUDA/10.0.130-GCC-7.3.0-2.30/bin:/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/binutils/2.30-GCCcore-7.3.0/bin:/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/GCCcore/7.3.0/bin:/home/twesterh/conda/condabin:/hpc/sw/hpc/bin:/hpc/sw/hpc/sbin:/usr/lib64/qt-3.3/bin:/hpc/eb/modules-tcl-1.923/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin'
export LD_LIBRARY_PATH='/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/CUDA/10.0.130-GCC-7.3.0-2.30/lib64'

module load 2019
module load GCC/7.3.0-2.30
module load CUDA/10.0.130-GCC-7.3.0-2.30
export PATH=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/CUDA/10.0.130-GCC-7.3.0-2.30/bin:/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/binutils/2.30-GCCcore-7.3.0/bin:/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/GCCcore/7.3.0/bin:/home/twesterh/conda/condabin:/hpc/sw/hpc/bin:/hpc/sw/hpc/sbin:/usr/lib64/qt-3.3/bin:/hpc/eb/modules-tcl-1.923/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
export LD_LIBRARY_PATH=/sw/arch/RedHatEnterpriseServer7/EB_production/2019/software/CUDA/10.0.130-GCC-7.3.0-2.30/lib64
. ~/conda/etc/profile.d/conda.sh
conda activate nqs_dev
pushd conda/gpu
conda build -c defaults -c conda-forge .
popd

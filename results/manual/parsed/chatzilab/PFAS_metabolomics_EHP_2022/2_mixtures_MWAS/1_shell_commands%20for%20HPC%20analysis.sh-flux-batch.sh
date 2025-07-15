#!/bin/bash
#FLUX: --job-name=frigid-leg-2889
#FLUX: --queue=conti
#FLUX: --priority=16

export PKG_CONFIG_PATH='/packages/jags/4.3.0/lib/pkgconfig'

ssh jagoodri@discovery.usc.edu
cd /project/dconti_624/Users/jagoodri/pfas_mixtures_metabolomics_sol
sbatch 1_1_solar_mixtures_mwas_hpc.job
cd /project/dconti_624/Users/jagoodri/pfas_mixtures_metabolomics_chs
sbatch 1_2_chs_mixtures_mwas_hpc.job
cd /project/dconti_624/Users/jagoodri/pfas_mixtures_metabolomics_sol_chs_pooled
sbatch 1_6_pooled_mixtures_mwas_hpc.job
exit
ssh jagoodri@endeavour.usc.edu
cd /project/dconti_624/Users/jagoodri/sol
dos2unix test_pbdmpi.sh
sbatch test_pbdmpi.sh
module load gcc/11.2.0 patchelf
patchelf --set-rpath /spack/apps2/linux-centos7-x86_64/gcc-11.2.0/jags-4.3.0-d373ytkqeamusbww7n2qjxyfwgikw2w5/lib /home1/jagoodri/R/x86_64-pc-linux-gnu-library/4.1/rjags/libs/rjags.so
module spider jags
module load usc r
module load jags
module load gcc/11.3.0
module load openblas/0.3.18
export PKG_CONFIG_PATH=/packages/jags/4.3.0/lib/pkgconfig
pkg-config ––modversion jags
R
install.packages("rjags", configure.args="––enable-rpath")
install.packages("R2jags", configure.args="––enable-rpath")

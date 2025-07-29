#!/bin/bash
#FLUX: --job-name=r_spack
#FLUX: --queue=test
#FLUX: -t=10
#FLUX: --urgency=16

. /n/holylabs/LABS/jharvard_lab/Users/jharvard/spack/share/spack/setup-env.sh
echo "spack version"
spack --version
spack load r-codetools
spack load r-rgdal
spack load r-raster
spack load r-terra
Rscript --vanilla r_spack_load_libs.R > r_spack_load_libs.Rout 2>&1

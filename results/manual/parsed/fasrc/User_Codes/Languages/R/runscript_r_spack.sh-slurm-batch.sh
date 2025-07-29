#!/bin/bash
#SBATCH --job-name=r_spack
#SBATCH --output=myoutput_%j.out
#SBATCH --error=myerrors_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4g
#SBATCH --time=00:00:10
#SBATCH --partition=test

. /n/holylabs/LABS/jharvard_lab/Users/jharvard/spack/share/spack/setup-env.sh
echo "spack version"
spack --version
spack load r-codetools
spack load r-rgdal
spack load r-raster
spack load r-terra
Rscript --vanilla r_spack_load_libs.R > r_spack_load_libs.Rout 2>&1

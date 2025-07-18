#!/bin/bash
#FLUX: --job-name=BNSBu.job
#FLUX: --queue=shared
#FLUX: -t=7200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/thussenot/MultiNest/lib/:$LD_LIBRARY_PATH'

module purge
module load sdsc cpu/0.15.4 gcc/9.2.0 openmpi/4.1.1
module load anaconda3/2020.11
source /cm/shared/apps/spack/cpu/opt/spack/linux-centos8-zen2/gcc-10.2.0/anaconda3-2020.11-weucuj4yrdybcuqro5v3mvuq3po7rhjt/etc/profile.d/conda.sh
conda activate multinest
export LD_LIBRARY_PATH=/home/thussenot/MultiNest/lib/:$LD_LIBRARY_PATH
mpiexec -n 32 lightcurve-analysis --model Bu2022Ye --svd-path /home/thussenot/nmma/svdmodels --outdir outdirBNSBu32cores --label AT170817 --prior ./Bu2022Ye_AT170817.prior --tmin 0.01 --tmax 26 --dt 0.01  --nlive 2048 --Ebv-max 0 --trigger-time 57982.52851851852 --data ../../AT2017gfo_reduced.dat --plot --xlim 0,14 --ylim 26,16 --bestfit --interpolation-type tensorflow

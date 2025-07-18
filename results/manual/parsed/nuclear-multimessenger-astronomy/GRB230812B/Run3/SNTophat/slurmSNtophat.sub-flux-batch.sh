#!/bin/bash
#FLUX: --job-name=nmmaSNtophat.job
#FLUX: --queue=shared
#FLUX: -t=43200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/home/thussenot/MultiNest/lib/:$LD_LIBRARY_PATH'

module purge
module load sdsc cpu/0.15.4 gcc/9.2.0 openmpi/4.1.1
module load anaconda3/2020.11
source /cm/shared/apps/spack/cpu/opt/spack/linux-centos8-zen2/gcc-10.2.0/anaconda3-2020.11-weucuj4yrdybcuqro5v3mvuq3po7rhjt/etc/profile.d/conda.sh
conda activate multinest
export LD_LIBRARY_PATH=/home/thussenot/MultiNest/lib/:$LD_LIBRARY_PATH
mpiexec -n 32 lightcurve-analysis --model nugent-hyper,TrPi2018 --outdir outdirSNtophat32cores --label GRB230812B --prior ./nugent_TrPi2018GRB230812B.prior --conditional-gaussian-prior-thetaObs --conditional-gaussian-prior-N-sigma 1 --jet-type -1 --tmin 0.01 --tmax 32 --dt 0.01 --nlive 2048 --Ebv-max 0 --trigger-time 60168.79041667 --data ../../GRB230812B_X_UV_griz_radiov3.txt --plot --xlim 0,32 --ylim 30,18

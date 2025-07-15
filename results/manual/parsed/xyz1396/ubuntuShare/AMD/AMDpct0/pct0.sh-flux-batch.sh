#!/bin/bash
#FLUX: --job-name=MSlabel0
#FLUX: -N=3
#FLUX: -n=27
#FLUX: --queue=omicsbio
#FLUX: -t=3596400
#FLUX: --priority=16

export OMP_NUM_THREADS='10'
export OMPI_MCA_btl_openib_allow_ib='1'
export OMPI_MCA_btl_openib_if_include='mlx4_0:1'

module load CMake/3.15.3-GCCcore-8.3.0 OpenMPI/3.1.4-GCC-8.3.0
export OMP_NUM_THREADS=10
export OMPI_MCA_btl_openib_allow_ib=1
export OMPI_MCA_btl_openib_if_include="mlx4_0:1"
binPath="/ourdisk/hpc/prebiotics/yixiong/auto_archive_notyet/ubuntuShare/EcoliSIP"
binPath2=$binPath
binPath="/scratch/yixiong/working/bin"
time mpirun -np 27 $binPath/SiprosV3mpi \
    -g configs \
    -w ft \
    -o sip
binPath=$binPath2
source ~/miniconda3/etc/profile.d/conda.sh
echo "Filter PSM"
conda activate pypy2
time pypy ${binPath}/scripts/sipros_peptides_filtering.py \
    -c /scratch/yixiong/AMDpct50/SiproConfig.N15.cfg \
    -w sip
pypy ${binPath}/scripts/sipros_peptides_assembling.py \
    -c /scratch/yixiong/AMDpct50/SiproConfig.N15.cfg \
    -w sip
pypy ${binPath}/scripts/ClusterSip.py \
    -c /scratch/yixiong/AMDpct50/SiproConfig.N15.cfg \
    -w sip

#!/bin/bash
#FLUX: --job-name="rfm_Openfoam_Mbike_1_job"
#FLUX: -n=32
#FLUX: --exclusive
#FLUX: --priority=16

export SLURM_MPI_TYPE='pmix_v2'
export UCX_NET_DEVICES='mlx5_0:1'

module load gcc/9.3.0-5abm3xg
module load openmpi/4.0.3-qpsxmnc
export SLURM_MPI_TYPE=pmix_v2
export UCX_NET_DEVICES=mlx5_0:1
module load openfoam-org/7-4zgjbg2
tar --strip-components 2 -xf Motorbike_bench_template.tar.gz bench_template/basecase
./Allclean
sed -i -- "s/method .*/method          scotch;/g" system/decomposeParDict
sed -i -- "s/numberOfSubdomains .*/numberOfSubdomains 32;/g" system/decomposeParDict
sed -i -- 's/    #include "streamLines"//g' system/controlDict
sed -i -- 's/    #include "wallBoundedStreamLines"//g' system/controlDict
sed -i -- 's|caseDicts|caseDicts/mesh/generation|' system/meshQualityDict
./Allmesh
time \
srun simpleFoam -parallel

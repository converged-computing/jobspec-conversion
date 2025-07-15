#!/bin/bash
#FLUX: --job-name=namd2
#FLUX: -N=2
#FLUX: --queue=thor
#FLUX: -t=1800
#FLUX: --priority=16

module purge
module load md/namd/2.12-hpcx-2.0.0-intel-2018.1.163
MPI_FLAGS="--display-map --report-bindings --map-by core --bind-to core"
UCX_FLAGS="-mca pml ucx -mca mtl ^mxm -x UCX_NET_DEVICES=mlx5_0:1 -x UCX_TLS=rc_x,shm,self"
HCOLL_FLAGS="-mca coll_fca_enable 0 -mca coll_hcoll_enable 1 -x HCOLL_MAIN_IB=mlx5_0:1"
EXE=namd2
INPUT=apoa1.namd
cd $SLURM_SUBMIT_DIR
mkdir namd
cd namd
wget -c http://www.ks.uiuc.edu/Research/namd/utilities/apoa1.tar.gz
tar zxpvf apoa1.tar.gz
cd apoa1
sed -i.bak 's/\/usr//' apoa1.namd
time mpirun ${MPI_FLAGS} ${UCX_FLAGS} ${HCOLL_FLAGS} ${EXE} ${INPUT}

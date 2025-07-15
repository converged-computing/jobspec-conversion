#!/bin/bash
#FLUX: --job-name=arid-destiny-9059
#FLUX: -n=220
#FLUX: --queue=compute
#FLUX: -t=900
#FLUX: --urgency=16

export OMPI_MCA_pml='ucx'
export OMPI_MCA_btl='self'
export OMPI_MCA_osc='pt2pt'
export UCX_IB_ADDR_TYPE='ib_global'
export OMPI_MCA_coll='^ml,hcoll'
export OMPI_MCA_coll_hcoll_enable='0'
export HCOLL_ENABLE_MCAST_ALL='0'
export HCOLL_MAIN_IB='mlx5_0:1'
export UCX_NET_DEVICES='mlx5_0:1'
export UCX_TLS='mm,knem,cma,dc_mlx5,dc_x,self'
export UCX_UNIFIED_MODE='y'
export HDF5_USE_FILE_LOCKING='FALSE'
export OMPI_MCA_io='romio321'
export UCX_HANDLE_ERRORS='bt'
export I_MPI_PMI_LIBRARY='/usr/lib64/libpmi2.so'

spack load intel-oneapi-mpi@2021.5.0%intel@2021.5.0
spack load intel-oneapi-compilers@2022.0.1
spack load intel-oneapi-mkl@2022.0.1%gcc@11.2.0
spack load metis@5.1.0%intel@2021.5.0
export OMPI_MCA_pml="ucx"
export OMPI_MCA_btl=self
export OMPI_MCA_osc="pt2pt"
export UCX_IB_ADDR_TYPE=ib_global
export OMPI_MCA_coll="^ml,hcoll"
export OMPI_MCA_coll_hcoll_enable="0"
export HCOLL_ENABLE_MCAST_ALL="0"
export HCOLL_MAIN_IB=mlx5_0:1
export UCX_NET_DEVICES=mlx5_0:1
export UCX_TLS=mm,knem,cma,dc_mlx5,dc_x,self
export UCX_UNIFIED_MODE=y
export HDF5_USE_FILE_LOCKING=FALSE
export OMPI_MCA_io="romio321"
export UCX_HANDLE_ERRORS=bt
ulimit -s 102400
ulimit -c 0
set -e
echo Here comes the Nodelist:
echo $SLURM_JOB_NODELIST
echo Here comes the partition the job runs in:
echo $SLURM_JOB_PARTITION
cd $SLURM_SUBMIT_DIR
source ModulesPlusPaths2LoadIntelMPI.sh
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi2.so
make compile
make ini
make grid
srun -l --mpi=pmi2 --export=ALL --cpu_bind=cores --distribution=block:cyclic -n 220 ElmerSolver_mpi Forward.sif

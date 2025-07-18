#!/bin/bash
#FLUX: --job-name=fesom2.0
#FLUX: -n=7560
#FLUX: --queue=compute2,compute
#FLUX: -t=1800
#FLUX: --urgency=16

export I_MPI_FABRICS='shm:dapl'
export I_MPI_FALLBACK='disable'
export I_MPI_SLURM_EXT='1'
export I_MPI_LARGE_SCALE_THRESHOLD='8192 # set to a value larger than the number of MPI-tasks used !!!'
export I_MPI_DYNAMIC_CONNECTION='1'
export I_MPI_CHECK_DAPL_PROVIDER_COMPATIBILITY='0'
export I_MPI_HARD_FINALIZE='1'
export OMPI_MCA_pml='cm         # sets the point-to-point management layer'
export OMPI_MCA_mtl='mxm        # sets the matching transport layer (MPI-2 one-sided comm.)'
export MXM_RDMA_PORTS='mlx5_0:1'
export MXM_LOG_LEVEL='ERROR'
export MXM_HANDLE_ERRORS='bt'
export UCX_HANDLE_ERRORS='bt'
export OMPI_MCA_coll='^fca              # disable FCA for collective MPI routines'
export OMPI_MCA_coll_hcoll_enable='1    # enable HCOLL for collective MPI routines'
export OMPI_MCA_coll_hcoll_priority='95'
export OMPI_MCA_coll_hcoll_np='8        # use HCOLL for all communications with more than 8 tasks'
export HCOLL_MAIN_IB='mlx5_0:1'
export HCOLL_ENABLE_MCAST='1'
export HCOLL_ENABLE_MCAST_ALL='1'
export HCOLL_ML_DISABLE_BARRIER='1'
export HCOLL_ML_DISABLE_IBARRIER='1'
export HCOLL_ML_DISABLE_BCAST='1'
export HCOLL_ML_DISABLE_REDUCE='1'

ulimit -s unlimited
whichMPI=INTELMPI
if test "${whichMPI}" == "INTELMPI"; then
export I_MPI_FABRICS=shm:dapl
export I_MPI_FALLBACK=disable
export I_MPI_SLURM_EXT=1
export I_MPI_LARGE_SCALE_THRESHOLD=8192 # set to a value larger than the number of MPI-tasks used !!!
export I_MPI_DYNAMIC_CONNECTION=1
export I_MPI_CHECK_DAPL_PROVIDER_COMPATIBILITY=0
export I_MPI_HARD_FINALIZE=1
fi
if test "${whichMPI}" == "BULLMPI"; then
export OMPI_MCA_pml=cm         # sets the point-to-point management layer
export OMPI_MCA_mtl=mxm        # sets the matching transport layer (MPI-2 one-sided comm.)
export MXM_RDMA_PORTS=mlx5_0:1
fi
if test "${whichMPI}" == "OPENMPI"; then
export OMPI_MCA_pml=cm         # sets the point-to-point management layer
export OMPI_MCA_mtl=mxm        # sets the matching transport layer (MPI-2 one-sided comm.)
export MXM_RDMA_PORTS=mlx5_0:1
export MXM_LOG_LEVEL=ERROR
export MXM_HANDLE_ERRORS=bt
export UCX_HANDLE_ERRORS=bt
export OMPI_MCA_coll=^fca              # disable FCA for collective MPI routines
export OMPI_MCA_coll_hcoll_enable=1    # enable HCOLL for collective MPI routines
export OMPI_MCA_coll_hcoll_priority=95
export OMPI_MCA_coll_hcoll_np=8        # use HCOLL for all communications with more than 8 tasks
export HCOLL_MAIN_IB=mlx5_0:1
export HCOLL_ENABLE_MCAST=1
export HCOLL_ENABLE_MCAST_ALL=1
export HCOLL_ML_DISABLE_BARRIER=1
export HCOLL_ML_DISABLE_IBARRIER=1
export HCOLL_ML_DISABLE_BCAST=1
export HCOLL_ML_DISABLE_REDUCE=1
fi
set -x
echo Submitted job: $jobid
squeue -u $USER
JOBID=`echo $SLURM_JOB_ID |cut -d"." -f1`
ln -s ../bin/fesom.x .           # cp -n ../bin/fesom.x
cp -n ../config/namelist.config  .
cp -n ../config/namelist.forcing .
cp -n ../config/namelist.oce     .
cp -n ../config/namelist.ice     .
cp -n ../config/namelist.icepack .
date
srun --mpi=pmi2 fesom.x > "fesom2.0.out"
date

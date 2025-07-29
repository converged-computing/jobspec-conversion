#!/bin/bash
#FLUX: --job-name=Color-dense
#FLUX: --exclusive
#FLUX: --queue=batch
#FLUX: -t=600
#FLUX: --urgency=16

export PE_MPICH_GTL_DIR_amd_gfx90a='-L${CRAY_MPICH_ROOTDIR}/gtl/lib'
export PE_MPICH_GTL_LIBS_amd_gfx90a='-lmpi_gtl_hsa'
export MPICH_GPU_SUPPORT_ENABLED='1'
export LD_LIBRARY_PATH='${CRAY_LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}'
export LBPM_BIN='/ccs/proj/csc380/mcclurej/crusher/LBPM/bin'

module load PrgEnv-amd
module load rocm/4.5.0
module load cray-mpich
module load cray-hdf5-parallel
export PE_MPICH_GTL_DIR_amd_gfx90a="-L${CRAY_MPICH_ROOTDIR}/gtl/lib"
export PE_MPICH_GTL_LIBS_amd_gfx90a="-lmpi_gtl_hsa"
export MPICH_GPU_SUPPORT_ENABLED=1
export LD_LIBRARY_PATH=${CRAY_LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}
export LBPM_BIN=/ccs/proj/csc380/mcclurej/crusher/LBPM/bin
echo "Running Color LBM"
MYCPUBIND="--cpu-bind=verbose,map_cpu:57,33,25,1,9,17,41,49"
srun --verbose -N1 -n8 --cpus-per-gpu=8 --gpus-per-task=1 --gpu-bind=closest ${MYCPUBIND} $LBPM_BIN/lbpm_color_simulator input.db
exit;

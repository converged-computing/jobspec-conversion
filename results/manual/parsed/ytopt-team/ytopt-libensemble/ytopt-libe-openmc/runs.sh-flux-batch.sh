#!/bin/bash
#FLUX: --job-name=carnivorous-kerfuffle-8083
#FLUX: --priority=16

export EXE='run_ytopt.py'
export COMMS='--comms local'
export NWORKERS='--nworkers ${nws}"  # extra worker running generator (no resources needed)'
export CONDA_ENV_NAME='ytune'
export PMI_NO_FORK='1 # Required for python kills on Theta'
export HSA_IGNORE_SRAMECC_MISREPORT='1'
export PE_MPICH_GTL_DIR_amd_gfx90a='-L${CRAY_MPICH_ROOTDIR}/gtl/lib'
export PE_MPICH_GTL_LIBS_amd_gfx90a='-lmpi_gtl_hsa'
export PYTHONNOUSERSITE='1'

let nnds=4
let nranks=1
let nws=5
let appto=500
./processcp.pl ${nranks}
./plopper.pl plopper.py ${appto}
cat >batch.job <<EOF
export EXE=run_ytopt.py
export COMMS="--comms local"
export NWORKERS="--nworkers ${nws}"  # extra worker running generator (no resources needed)
export CONDA_ENV_NAME=ytune
export PMI_NO_FORK=1 # Required for python kills on Theta
module unload trackdeps
module unload darshan
module unload xalt
source /ccs/home/wuxf/anaconda3/etc/profile.d/conda.sh
module load PrgEnv-amd/8.3.3
module load cray-hdf5/1.12.0.7
module load cmake
module load craype-accel-amd-gfx90a
module load rocm/4.5.2
module load cray-mpich/8.1.14
export HSA_IGNORE_SRAMECC_MISREPORT=1
export PE_MPICH_GTL_DIR_amd_gfx90a="-L${CRAY_MPICH_ROOTDIR}/gtl/lib"
export PE_MPICH_GTL_LIBS_amd_gfx90a="-lmpi_gtl_hsa"
export PYTHONNOUSERSITE=1
conda activate \$CONDA_ENV_NAME
python \$EXE \$COMMS \$NWORKERS --learner=RF --max-evals=256 > out.txt 2>&1
EOF
chmod +x batch.job
sbatch batch.job

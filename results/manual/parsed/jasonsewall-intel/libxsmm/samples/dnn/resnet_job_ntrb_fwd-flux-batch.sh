#!/bin/bash
#FLUX: --job-name=strawberry-carrot-2939
#FLUX: -c=272
#FLUX: --queue=knmb3
#FLUX: -t=7200
#FLUX: --urgency=16

export I_MPI_MIC='1'
export INTEL_LICENSE_FILE='/swtools/intel/licenses/'
export OMP_NUM_THREADS='64'
export KMP_AFFINITY='proclist=[2-67],granularity=thread,explicit,norespect'
export LIBXSMM_DNN_THREAD_PRIVATE_JIT='1'

source /swtools/intel/compilers_and_libraries_2017.2.174/linux/bin/compilervars.sh intel64
source /swtools/intel/compilers_and_libraries_2017.2.174/linux/mpi/bin64/mpivars.sh 
export I_MPI_MIC=1
export INTEL_LICENSE_FILE=/swtools/intel/licenses/
export OMP_NUM_THREADS=64
export KMP_AFFINITY=proclist=[2-67],granularity=thread,explicit,norespect
export LIBXSMM_DNN_THREAD_PRIVATE_JIT=1
srun -n 1 ./run_resnet50.sh 64 100 1 f32 F L 1 > resnet_fwd_results_knm

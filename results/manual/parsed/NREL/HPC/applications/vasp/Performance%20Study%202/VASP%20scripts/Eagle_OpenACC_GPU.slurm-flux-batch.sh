#!/bin/bash
#FLUX: --job-name=vasp_gpu
#FLUX: -N=4
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/nopt/nrel/apps/220511a/install/opt/spack/linux-centos7-skylake_avx512/gcc-12.1.0/nvhpc-22.3-c4qk6fly5hls3mjimoxg6vyuy5cc3vti/Linux_x86_64/22.3/compilers/extras/qd/lib:$LD_LIBRARY_PATH'
export PATH='/projects/hpcapps/tkaiser2/vasp/6.3.1/nvhpc_acc:$PATH'

module purge
module use /nopt/nrel/apps/220511a/modules/lmod/linux-centos7-x86_64/gcc/12.1.0
ml fftw nvhpc
export LD_LIBRARY_PATH=/nopt/nrel/apps/220511a/install/opt/spack/linux-centos7-skylake_avx512/gcc-12.1.0/nvhpc-22.3-c4qk6fly5hls3mjimoxg6vyuy5cc3vti/Linux_x86_64/22.3/compilers/extras/qd/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/nopt/nrel/apps/220511a/install/opt/spack/linux-centos7-skylake_avx512/gcc-12.1.0/nvhpc-22.3-c4qk6fly5hls3mjimoxg6vyuy5cc3vti/Linux_x86_64/22.3/compilers/extras/qd/lib:$LD_LIBRARY_PATH
export PATH=/projects/hpcapps/tkaiser2/vasp/6.3.1/nvhpc_acc:$PATH
mpirun -npernode 2 vasp_std &> out

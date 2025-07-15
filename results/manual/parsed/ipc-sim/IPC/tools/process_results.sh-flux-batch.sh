#!/bin/bash
#FLUX: --job-name=process_results
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --priority=16

if type "module" > /dev/null 2>&1; then
    # Load modules
    module purge
    module load cgal/intel/4.10b1
    module swap boost/intel/1.62.0 boost/intel/1.71.0
    module load suitesparse/intel/4.5.4 swig/gnu/3.0.11 ilmbase/intel/2.2.0 \
    openexr/intel/2.2.0 openmpi/intel/3.1.4 fftw/intel/3.3.6-pl2 \
    glew/intel/2.1.0 lapack/gnu/3.7.0
    module load cmake/intel/3.11.4 mosek/8.1.0.64 tbb/intel/2017u3
    module load gurobi/9.0.0
    module load gmp/gnu/6.1.2
    module swap gcc gcc/9.1.0
fi
python $HOME/IPC/tools/process_SQP_results.py $(realpath $HOME/IPC/SQP-sweep-2020-01-17)
python $HOME/IPC/tools/process_IP_results.py $(realpath $HOME/IPC/SQP-sweep-2020-01-17)

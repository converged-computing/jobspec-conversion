#!/bin/bash
#FLUX: --job-name=jupyter
#FLUX: --queue=debug
#FLUX: -t=3600
#FLUX: --urgency=16

export BASEDIR='/projects/hpcapps/tkaiser'
export MYVERSION='may12'
export LD_LIBRARY_PATH='/nopt/nrel/apps/cuda/11.2/targets/x86_64-linux/lib:/nopt/nrel/apps/base/2020-05-12/spack/opt/spack/linux-centos7-x86_64/gcc-4.8.5/gcc-6.5.0-aov4u2ocxtqf4bwif4hc7sga4cvccpxm/lib64:/nopt/nrel/apps/base/2020-05-12/spack/opt/spack/linux-centos7-x86_64/gcc-4.8.5/gcc-6.5.0-aov4u2ocxtqf4bwif4hc7sga4cvccpxm/lib:/nopt/nrel/apps/cudnn/8.1.1-cuda-11.2/lib64:/nopt/nrel/apps/cuda/11.2/lib64:/nopt/mpi/mpt-2.23/lib:/nopt/slurm/current/lib::'

export BASEDIR=/projects/hpcapps/tkaiser
export MYVERSION=may12
module load conda
module load mpt
module load cuda/11.2   cudnn/8.1.1/cuda-11.2   gcc/8.4.0
source activate 
source activate $BASEDIR/$MYVERSION
export LD_LIBRARY_PATH=/nopt/nrel/apps/cuda/11.2/targets/x86_64-linux/lib:/nopt/nrel/apps/base/2020-05-12/spack/opt/spack/linux-centos7-x86_64/gcc-4.8.5/gcc-6.5.0-aov4u2ocxtqf4bwif4hc7sga4cvccpxm/lib64:/nopt/nrel/apps/base/2020-05-12/spack/opt/spack/linux-centos7-x86_64/gcc-4.8.5/gcc-6.5.0-aov4u2ocxtqf4bwif4hc7sga4cvccpxm/lib:/nopt/nrel/apps/cudnn/8.1.1-cuda-11.2/lib64:/nopt/nrel/apps/cuda/11.2/lib64:/nopt/mpi/mpt-2.23/lib:/nopt/slurm/current/lib::
date      > ~/jupyter.log
hostname >> ~/jupyter.log
jupyter notebook --NotebookApp.password='' --no-browser  >> ~/jupyter.log 2>&1

#!/bin/bash
#FLUX: --job-name=stinky-bits-3021
#FLUX: --priority=16

export CONDA_PREFIX='/tmp/test_{env_dir_random}/test/miniconda3'
export CONDA_PYTHON_EXE='/tmp/test_{env_dir_random}/test/miniconda3/bin/python'
export CONDA_EXE='/tmp/test_{env_dir_random}/test/miniconda3/bin/conda'
export PATH='/dev/shm/bin:/tmp/test_{env_dir_random}/test/miniconda3/envs/mapping/bin:/tmp/test_{env_dir_random}/test/miniconda3/bin:/opt/apps/cmake/3.16.1/bin:/opt/apps/intel18/python2/2.7.15/bin:/opt/apps/autotools/1.1/bin:/opt/apps/git/2.24.1/bin:/opt/apps/libfabric/1.7.0/bin:/opt/apps/intel18/impi/18.0.2/bin:/opt/intel/compilers_and_libraries_2018.2.199/linux/mpi/intel64/bin:/opt/intel/compilers_and_libraries_2018.2.199/linux/bin/intel64:/opt/apps/gcc/6.3.0/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/opt/dell/srvadmin/bin:.'
export OMP_NUM_THREADS='48'

{email_str}
{email_type_str}
mkdir /tmp/test_{env_dir_random}
tar -xf /work2/05622/lhq/test_conda.tar -C /tmp/test_{env_dir_random}
export CONDA_PREFIX=/tmp/test_{env_dir_random}/test/miniconda3
export CONDA_PYTHON_EXE=/tmp/test_{env_dir_random}/test/miniconda3/bin/python
export CONDA_EXE=/tmp/test_{env_dir_random}/test/miniconda3/bin/conda
export PATH=/dev/shm/bin:/tmp/test_{env_dir_random}/test/miniconda3/envs/mapping/bin:/tmp/test_{env_dir_random}/test/miniconda3/bin:/opt/apps/cmake/3.16.1/bin:/opt/apps/intel18/python2/2.7.15/bin:/opt/apps/autotools/1.1/bin:/opt/apps/git/2.24.1/bin:/opt/apps/libfabric/1.7.0/bin:/opt/apps/intel18/impi/18.0.2/bin:/opt/intel/compilers_and_libraries_2018.2.199/linux/mpi/intel64/bin:/opt/intel/compilers_and_libraries_2018.2.199/linux/bin/intel64:/opt/apps/gcc/6.3.0/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/opt/dell/srvadmin/bin:.
find /tmp/test_{env_dir_random}/test/miniconda3/ -type f -print0 | sed 's/ /\\ /g; s/(/\\(/g; s/)/\\)/g' | xargs -0 -P 30 -I % sh -c '/bin/sed -i "s/\/tmp\/test\/miniconda3\/envs\/mapping\/bin\/python/\/tmp\/test_{env_dir_random}\/test\/miniconda3\/envs\/mapping\/bin\/python/" %'
pip install cemba_data --upgrade
pip install schicluster --upgrade
which python
which snakemake
which yap
which allcools
which bismark
date
hostname
pwd
export OMP_NUM_THREADS=48
{command}
rm -rf /tmp/test*

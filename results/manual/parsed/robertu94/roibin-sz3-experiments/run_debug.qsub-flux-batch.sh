#!/bin/bash
#FLUX: --job-name=roibin_debug
#FLUX: -N=10
#FLUX: -t=54000
#FLUX: --priority=16

export PROJECT_DIR='/lcrc/project/ECP-EZ/public/compression/roibin-sz3'
export workdir='$PROJECT_DIR/roibin-sz3-experiments/'

export PROJECT_DIR=/lcrc/project/ECP-EZ/public/compression/roibin-sz3
export workdir=$PROJECT_DIR/roibin-sz3-experiments/
cd $workdir
module load gcc/10.2.0-z53hda3
module load intel-mpi/2019.10.317-qn674hj 
module load intel-mkl/2020.4.304
source $HOME/git/spack-bebop/share/spack/setup-env.sh
source $HOME/git/spack-bebop/share/spack/spack-completion.bash
spack env activate .
mkdir -p $PROJECT_DIR/debug
echo srun -n 360 $workdir/build/roibin_test -c 1 -b -d -D $PROJECT_DIR/debug/ -f $PROJECT_DIR/cxic0415_0076.cxi \
    -o $PROJECT_DIR/cxic0415_0076.cxi.roibin.json -p $workdir/share/table2/b3_abs90_dim2.json
srun -n 360 $workdir/build/roibin_test -c 1 -b -d -D $PROJECT_DIR/debug/ -f $PROJECT_DIR/cxic0415_0076.cxi \
    -o $PROJECT_DIR/cxic0415_0076.cxi.roibin.json -p $workdir/share/table2/b3_abs90_dim2.json

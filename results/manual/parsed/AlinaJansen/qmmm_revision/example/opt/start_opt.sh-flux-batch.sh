#!/bin/bash
#FLUX: --job-name=cap_scan
#FLUX: -c=8
#FLUX: --queue=main
#FLUX: -t=600
#FLUX: --priority=16

export GMXLIB='/home/jansea92/GROLIB/top'
export TMPDIR='/scratch/$USER/qmmm/tmp.$SLURM_JOBID'
export PROJECT='`pwd`'

module load gaussian/g16_A03
module load GROMACS/2019-foss-2018b # GROMACS
module load Python/3.6.6-foss-2018b
source /scratch/spetry/Gromacs_bin/bin/GMXRC
module load CUDA/9.2.88-GCC-7.3.0-2.30
export GMXLIB=/home/jansea92/GROLIB/top
export TMPDIR=/scratch/$USER/qmmm/tmp.$SLURM_JOBID
if [ -d $TMPDIR ]; then
  echo "$TMPDIR exists; double job start; exit"
  exit 1
fi
mkdir -p $TMPDIR
export PROJECT=`pwd`
set -e
python ~/qmmm_revision/gmx2qmmm.py
cp -r * $PROJECT
cd ../
mv $TMPDIR completed_temp/.

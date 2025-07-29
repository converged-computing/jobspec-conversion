#!/bin/bash
#FLUX: --job-name=Tera_job
#FLUX: --queue=long
#FLUX: --urgency=16

export SCRDIR='/scratch/${ID}'
export OUTFILE='$SLURM_SUBMIT_DIR/out.dat'

ID=$SLURM_JOB_ID
export SCRDIR=/scratch/${ID}
mkdir $SCRDIR
source /opt/anaconda/anaconda3/etc/profile.d/conda.sh && conda activate qcfractal
MODULEPATH=/opt/easybuild/modules/all
module load Terachem/1.9.4.lua
export OUTFILE=$SLURM_SUBMIT_DIR/out.dat
echo $SCRDIR
echo $SLURM_SUBMIT_DIR
echo $OUTFILE
bash $SLURM_SUBMIT_DIR/relax.sh $SCRDIR $OUTFILE 2>&1 
rm -rf $SCRDIR

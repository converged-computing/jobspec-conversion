#!/bin/bash
#FLUX: --job-name=J56
#FLUX: --exclusive
#FLUX: --queue=standard
#FLUX: -t=1200
#FLUX: --urgency=16

export WORK='/mnt/lustre/a2fs-work3/work/e89/e89/louie/'
export PYTHONUSERBASE='$WORK/.local'
export PATH='$PYTHONUSERBASE/bin:$PATH'
export PYTHONPATH='$PYTHONUSERBASE/lib/python3.8/site-packages:$PYTHONPATH'
export MPLCONFIGDIR='$WORK/.config/matplotlib'
export OMP_NUM_THREADS='1'
export ASE_NWCHEM_COMMAND='srun --distribution=block:block --hint=nomultithread nwchem PREFIX.nwi > PREFIX.nwo'

cd $SLURM_SUBMIT_DIR
echo $SLURM_NODELIST
module load nwchem
module load cray-python
export WORK=/mnt/lustre/a2fs-work3/work/e89/e89/louie/
export PYTHONUSERBASE=$WORK/.local
export PATH=$PYTHONUSERBASE/bin:$PATH
export PYTHONPATH=$PYTHONUSERBASE/lib/python3.8/site-packages:$PYTHONPATH
export MPLCONFIGDIR=$WORK/.config/matplotlib
export OMP_NUM_THREADS=1
export ASE_NWCHEM_COMMAND="srun --distribution=block:block --hint=nomultithread nwchem PREFIX.nwi > PREFIX.nwo"
echo "Starting calculation at $(date)"
SECONDS=0
python3 3_ase_nwchem.py
duration=$SECONDS
echo "Calculation ended at $(date)"
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
exit

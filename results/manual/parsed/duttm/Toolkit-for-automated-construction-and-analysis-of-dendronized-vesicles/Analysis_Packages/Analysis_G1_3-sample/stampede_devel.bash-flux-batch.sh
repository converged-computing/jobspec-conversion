#!/bin/bash
#FLUX: --job-name=milky-chip-3637
#FLUX: --priority=16

gro=*.gro
xtc=*.xtc
echo "${gro} is here"
echo "${xtc} is here"
Dest=Parent
cp $gro $Dest/
cp $xtc $Dest/
export gro
export xtc
mkdir Outputs
. /home1/04676/tg839752/anaconda3/etc/profile.d/conda.sh
conda activate scw_test
gmx_exec="/opt/apps/intel18/impi18_0/gromacs/2018.3/bin/gmx_knl"
python_exec="python"
skip=1
export gmx_exec
export python_exec
export skip
cd $Dest/
./Wrapper.bash $gro $xtc
cd ../
rm $gro 
rm $xtc
cp -r $SLURM_SUBMIT_DIR/AND/Outputs/* $SLURM_SUBMIT_DIR/Outputs/
conda deactivate 
cd $SLURM_SUBMIT_DIR/
rm $gro 
rm $xtc
cd $SLURM_SUBMIT_DIR/$Dest/
rm $gro 
rm $xtc
conda deactivate 

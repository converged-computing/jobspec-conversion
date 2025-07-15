#!/bin/bash
#FLUX: --job-name=confused-nalgas-2295
#FLUX: --priority=16

source activate PAPER
PSA64Obs='/users/jkerriga/data/jkerriga/PSA64SingleDay'
BrownScripts='/users/jkerriga/brownscripts/jrk'
obs_list=($(ls -d  $PSA64Obs/zen*O))
echo ${obs_list[*]} |wc -w
cd $BrownScripts
filename=${obs_list[$SLURM_ARRAY_TASK_ID]}
echo $filename
echo 'Rephasing all observations to zenith...'
python rephase.py -C psa6240_FHD --onephs $filename
echo 'Fixing antenna tables...'
python fix_anttable.py "${filename}M"
echo 'Adding uvw coordinates...'
python add_uvws.py -C psa6240_FHD "${filename}MT"
echo 'Converting to UVFITS...'
python miriad2uvfits.py "${filename}MTU"
UVFITS='/users/jkerriga/data/jkerriga/SDOutput'
cd $UVFITS
obs_listFITS=$(ls -d *U.uvfits)
cd $BrownScripts
echo $obs_listFITS > obsfits.txt

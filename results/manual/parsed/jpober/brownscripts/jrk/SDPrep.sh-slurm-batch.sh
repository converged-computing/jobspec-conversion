#!/bin/bash
#SBATCH --job-name=FHDPrep
#SBATCH --output=SlurmOut/Prep_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=01:00:00
#SBATCH --partition=jpober-test
#SBATCH --array=0-68:1

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

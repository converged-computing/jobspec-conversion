#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=01:00:00
#SBATCH --constraint=amd
#SBATCH --array=0-XXXX

MSLIST=$1
BIND=$( python3 $HOME/parse_settings.py --BIND ) # SEE --> https://github.com/jurjen93/lofar_vlbi_helpers/blob/main/parse_settings.py
SIMG=$( python3 $HOME/parse_settings.py --SIMG )
LOFAR_HELPERS=$( python3 $HOME/parse_settings.py --lofar_helpers )
SCRIPT_DIR=${LOFAR_HELPERS}/phasediff_scores/phasediff_selection
mkdir -p phasediff_h5s
IFS=$'\r\n' GLOBIGNORE='*' command eval  'MSS=($(cat ${MSLIST}))'
MS=${MSS[${SLURM_ARRAY_TASK_ID}]}
mkdir ${MS}_folder
cp -r ${MS} ${MS}_folder
cd ${MS}_folder
chmod 755 ${SCRIPT_DIR}/*
singularity exec -B $BIND $SIMG ${SCRIPT_DIR}/phasediff.sh ${MS}
mv scalarphasediff0*phaseup.h5 ../phasediff_h5s
mv ${MS} ../
cd ../
rm -rf ${MS}_folder
singularity exec -B $BIND $SIMG python ${SCRIPT_DIR}/phasediff_output.py --h5 phasediff_h5s/*.h5

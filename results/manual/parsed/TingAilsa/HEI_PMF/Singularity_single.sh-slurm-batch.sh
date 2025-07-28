#!/bin/bash
#FLUX: --job-name=pmf_noGUI_try
#FLUX: -t=259200
#FLUX: --urgency=16

module load singularity
DOS_COMMAND="ME-2 PMF_bs_6f8xx_sealed_GUI_MOD.ini"
cd "cd /projects/HAQ_LAB/tzhang/pmf_no_gui/file_try/PMF_no_GUI"
cp iniparams_base_1.txt iniparams.txt
singularity exec /projects/HAQ_LAB/tzhang/pmf_no_gui/file_try/dosbox_container.sif dosbox -c "mount c ." -c "c:" -c "$DOS_COMMAND" -c "exit"
rm iniparams.txt

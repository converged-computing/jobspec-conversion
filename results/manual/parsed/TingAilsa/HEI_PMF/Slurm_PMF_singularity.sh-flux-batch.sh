#!/bin/bash
#FLUX: --job-name=pmf_noGUI_try
#FLUX: -t=259200
#FLUX: --urgency=16

module load r  #will load default r version
module load singularity
DOS_COMMAND="ME-2 PMF_bs_6f8xx_sealed_GUI_MOD.ini"
Cluster_number=$(( ($SLURM_ARRAY_TASK_ID - 1) / 6 + 1 ))
Factor_number=$(( ($SLURM_ARRAY_TASK_ID - 1) % 6 + 6 ))
cd "CSN_CMD_txt/Cluster_${Cluster_number}/Factor_${Factor_number}"
cp iniparams_base.txt iniparams.txt
singularity exec ../dosbox_container.sif dosbox -c "mount c ." -c "c:" -c "$DOS_COMMAND" -c "exit"
rm iniparams.txt
mv CSN_C_${Cluster_number}_F_${Cluster_number}_.txt CSN_C_${Cluster_number}_F_${Factor_number}_base.txt
Rscript /projects/HAQ_LAB/tzhang/pmf_no_gui/file_try/minQ_Task_numoldsol.R CSN_C_${Cluster_number}_F_${Factor_number}_base.txt
for param_file in iniparams_BS.txt iniparams_DISP.txt #iniparams_before_dualc.txt iniparams_BS_DISP.txt
do
cp ${param_file} iniparams.txt
$DOS_COMMAND
rm iniparams.txt
done

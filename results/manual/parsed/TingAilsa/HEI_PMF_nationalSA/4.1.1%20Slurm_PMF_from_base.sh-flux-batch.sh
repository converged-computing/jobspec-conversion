#!/bin/bash
#FLUX: --job-name=C_select
#FLUX: --queue=normal
#FLUX: -t=432000
#FLUX: --urgency=16

export LANG='C.UTF-8'

module load gnu10/10.3.0-ya
module load r
module load singularity
export LANG=C.UTF-8
set -x
dataset="IMPROVE"
SINGULARITY_BASE=/containers/hopper/Containers
CONTAINER=${SINGULARITY_BASE}/wine/wine.sif
Cluster_number=$(( ( ($SLURM_ARRAY_TASK_ID - 1) / 6 ) + 1 ))
Factor_number=$(( ( ($SLURM_ARRAY_TASK_ID - 1) % 6 ) + 6 ))
echo ${Cluster_number}
echo ${Factor_number}
ShR_SCRIPT_DIR="/projects/HAQ_LAB/tzhang/pmf_no_gui/${dataset}_CMD_txt_noCsub_noExtreme"
BASE_SCRIPT_DIR="$ShR_SCRIPT_DIR/Cluster_${Cluster_number}/Factor_${Factor_number}"
SINGULARITY_RUN="singularity exec  -B ${BASE_SCRIPT_DIR}:/host_pwd --pwd /host_pwd"
SCRIPT=PMF_bs_6f8xx_sealed_GUI_MOD.ini
DOS_COMMAND="${SINGULARITY_RUN} ${CONTAINER} wine ${BASE_SCRIPT_DIR}/ME-2.exe ${SCRIPT}"
cd "Cluster_${Cluster_number}/Factor_${Factor_number}"
cp ../*.csv . #save to check if some code is useful for this path
echo $PWD
base_txt=$(find ${BASE_SCRIPT_DIR} -type f -name "*_base.txt" | wc -l)
base_txt_file=$(find ${BASE_SCRIPT_DIR} -type f -name "*_base.txt")
base_size=$(du -b "$base_txt_file" | awk '{print $1}')
base_size=${base_size:-0}
if [ -n "$base_txt_file" ]; then
    base_task_count=$(grep -c "Results written by postprocessing for task" "$base_txt_file")
else
    base_task_count=0
fi
echo "base_result.txt: " ${base_txt}
echo "base_result size: " ${base_size}
echo "base_task_count: " ${base_task_count}
function part1_NoRun {
    echo "Base files already present, skipping this run."
}
function part2_Base {
    echo "Start from Base run"
    cp iniparams_base_C_${Cluster_number}_F_${Factor_number}.txt iniparams.txt
    echo "Base parameter file changed"
    #echo $DOS_COMMAND
    #echo $PWD
    $DOS_COMMAND
    if [ $? -ne 0 ]; then echo "Error in Part Base"; return; fi
    rm iniparams.txt
    echo "Base Model Run completes"
    ### Analyze the output .txt file, generate the new value for numoldsol, and replace it in other iniparams.txt series using R
    mv ${dataset}_noCsub_noExtreme_C_${Cluster_number}_F_${Factor_number}_.txt ${dataset}_noCsub_noExtreme_C_${Cluster_number}_F_${Factor_number}_base.txt
    if [ $? -ne 0 ]; then echo "Error in Part Base"; return; fi
    echo "Base run finished!"
}
function part3_BS_DISP {
  echo "Execute BS & DISP"
    Rscript ${ShR_SCRIPT_DIR}/minQ_Task_numoldsol.R ${dataset}_noCsub_noExtreme_C_${Cluster_number}_F_${Factor_number}_base.txt ${Cluster_number} ${Factor_number} ${BASE_SCRIPT_DIR}
    if [ $? -ne 0 ]; then echo "Error in Part 1"; return; fi
    echo "minQ changed"
    # Run DOS command for BS, DISP, and BS-DISP analyses in turn
    for param_file in iniparams_BS_C_${Cluster_number}_F_${Factor_number}_use.txt iniparams_DISP_C_${Cluster_number}_F_${Factor_number}_use.txt
    do
      cp ${param_file} iniparams.txt
      if [ $? -ne 0 ]; then echo "Error in Part BS/DISP run"; return; fi
      $DOS_COMMAND
      if [ $? -ne 0 ]; then echo "Error in Part BS/DISP run"; return; fi
      rm iniparams.txt
    done
    # Rename the output from DISP
    mv DISPres1.txt ${dataset}_C_${Cluster_number}_F_${Factor_number}_DISPres1.txt
    echo "All runs executed!"
}
if [[ "$base_txt" -eq 0 ]] || [[ "$base_task_count" -lt 20 ]] || [[ "$base_size" -lt 1000 ]]; then
    part2_Base
    part3_BS_DISP
fi
exit 0 #terminates the script execution

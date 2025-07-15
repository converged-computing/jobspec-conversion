#!/bin/bash
#FLUX: --job-name=S_15t1mdl_0unc
#FLUX: --queue=normal
#FLUX: -t=432000
#FLUX: --urgency=16

export LANG='C.UTF-8'
export CONTAINER='${SINGULARITY_BASE}/wine/wine.sif'
export SINGULARITY_RUN='singularity exec --pwd=${BASE_SCRIPT_DIR}'
export SCRIPT='PMF_bs_6f8xx_sealed_GUI_MOD.ini'
export DOS_COMMAND='${SINGULARITY_RUN} ${CONTAINER} wine ${BASE_SCRIPT_DIR}/ME-2.exe ${SCRIPT}'

module load gnu10/10.3.0-ya
module load r
module load singularity
export LANG=C.UTF-8
dataset="CSN"
extremeMethod="15t1mdl0unc"
declare -A SLURM_MAP
site_serial=("001" "002" "003" "004" "005" "006" "007" "008" "009" "010" "011" "012" "013" "014" "015" "017" "018"  "019" "020" "021" "022" "023" "024" "025" "026" "027" "028" "029" "030" "031" "032" "033" "035" "036" "037" "038" "039" "040" "041" "042" "043" "044" "045" "046" "047" "048" "049" "050" "051" "052"  "053" "054" "055" "056" "057" "058" "059" "060" "061" "062" "063" "064" "065" "066" "067" "068" "069" "070" "072" "073" "074" "075" "076" "077" "080" "081" "082" "083" "084" "085" "086" "087" "088" "089" "090" "091" "092" "093" "094" "095" "096" "097" "098" "099" "100" "101" "102" "103" "104" "105" "106" "107" "108" "109" "110" "111" "112" "113" "114" "115" "116" "117" "118" "119" "120" "121" "122" "123" "124" "125" "126" "128" "130" "131" "132" "133" "135" "136" "138" "139" "140" "141" "142" "144" "147" "149" "150" "151")
task_id=1
for site_use in "${site_serial[@]}"; do
    for factor_number in {3..11}; do
        SLURM_MAP[$task_id]="${site_use}:${factor_number}"
        ((task_id++))
    done
done
mapped_value=${SLURM_MAP[$SLURM_ARRAY_TASK_ID]}
Site_serial=${mapped_value%:*}
Factor_number=${mapped_value#*:}
set -x
echo ${Site_serial}
echo ${Factor_number}
ShR_SCRIPT_DIR="/projects/HAQ_LAB/tzhang/pmf_no_gui/${dataset}_${extremeMethod}_site"
BASE_SCRIPT_DIR="$ShR_SCRIPT_DIR/S_${Site_serial}/Factor_${Factor_number}"
SINGULARITY_BASE=/containers/hopper/Containers
export CONTAINER=${SINGULARITY_BASE}/wine/wine.sif
export SINGULARITY_RUN="singularity exec --pwd=${BASE_SCRIPT_DIR}"
export SCRIPT=PMF_bs_6f8xx_sealed_GUI_MOD.ini
export DOS_COMMAND="${SINGULARITY_RUN} ${CONTAINER} wine ${BASE_SCRIPT_DIR}/ME-2.exe ${SCRIPT}"
cd "S_${Site_serial}/Factor_${Factor_number}"
cp ../*.csv . #save to check if some code is useful for this path
cp ${ShR_SCRIPT_DIR}/me2key.key .
cp ${ShR_SCRIPT_DIR}/PMF_ab_base.dat .
cp ${ShR_SCRIPT_DIR}/ME-2.exe .
cp ${ShR_SCRIPT_DIR}/PMF_bs_6f8xx_sealed_GUI_MOD.ini .
echo "Key&exe copy finished"
echo $PWD
base_txt=$(find ${BASE_SCRIPT_DIR} -type f -name "*_base.txt" | wc -l)
base_txt_file=$(find ${BASE_SCRIPT_DIR} -type f -name "*_base.txt")
base_size=$(du -b "$base_txt_file" | awk '{print $1}')
base_size=${base_size:-0}
Qm_task=$(find ${BASE_SCRIPT_DIR} -type f -name "*_Qm_task.txt" | wc -l)
use_txt=$(find ${BASE_SCRIPT_DIR} -type f -name "*_use.txt" | wc -l)
BS_txt=$(find ${BASE_SCRIPT_DIR} -type f -name "*_BS_.txt" | wc -l)
DISP_txt=$(find ${BASE_SCRIPT_DIR} -type f -name "*_DISP_.txt" | wc -l)
DISPres1=$(find ${BASE_SCRIPT_DIR} -type f -name "*_DISPres1.txt" | wc -l)
BS_size=$(find ${BASE_SCRIPT_DIR} -type f -name "*_BS_.txt" -exec du -b {} + | awk '{s+=$1} END {print s}')
BS_size=${BS_size:-0} # BS_size is set to 0 when no files are found
DISP_size=$(find ${BASE_SCRIPT_DIR} -type f -name "*_DISP_.txt" -exec du -b {} + | awk '{s+=$1} END {print s}')
DISP_size=${DISP_size:-0}
DISPres1_size=$(find ${BASE_SCRIPT_DIR} -type f -name "*_DISPres1.txt" -exec du -b {} + | awk '{s+=$1} END {print s}')
DISPres1_size=${DISPres1_size:-0}
if [ -n "$base_txt_file" ]; then
    base_task_count=$(grep -c "Results written by postprocessing for task" "$base_txt_file")
else
    base_task_count=0
fi
echo "base_result.txt: " ${base_txt}
echo "base_result size: " ${base_size}
echo "base_task_count: " ${base_task_count}
echo "Qm_task.txt: " ${Qm_task}
echo "use.txt: " ${use_txt}
echo "_BS_.txt: " ${BS_txt} " & size: " ${BS_size}
echo "_DISP_.txt: " ${DISP_txt}  " & size: " ${DISP_size}
echo "DISPres1.txt: " ${DISPres1} " & size: " ${DISPres1_size}
function part1_NoRun {
    echo "Base files already present, skipping this run."
}
function part2_Base {
    echo "Start from Base run"
    cp iniparams_base_S_${Site_serial}_F_${Factor_number}.txt iniparams.txt
    echo "Base parameter file changed"
    #echo $DOS_COMMAND
    #echo $PWD
    $DOS_COMMAND
    if [ $? -ne 0 ]; then echo "Error in Part Base"; return; fi
    rm iniparams.txt
    echo "Base Model Run completes"
    ### Analyze the output .txt file, generate the new value for numoldsol, and replace it in other iniparams.txt series using R
    mv ${dataset}_noCsub_${extremeMethod}_S_${Site_serial}_F_${Factor_number}_.txt ${dataset}_noCsub_${extremeMethod}_S_${Site_serial}_F_${Factor_number}_base.txt
    cp PMFreport.txt ${dataset}_noCsub_${extremeMethod}_S_${Site_serial}_F_${Factor_number}_base_PMFreport.txt
    if [ $? -ne 0 ]; then echo "Error in Part Base"; return; fi
    echo "Base run finished!"
}
function part3_BS_DISP {
  echo "Execute BS & DISP"
    Rscript ${ShR_SCRIPT_DIR}/minQ_Task_numoldsol_site.R ${dataset}_noCsub_${extremeMethod}_S_${Site_serial}_F_${Factor_number}_base_PMFreport.txt ${Site_serial} ${Factor_number} ${BASE_SCRIPT_DIR}
    if [ $? -ne 0 ]; then echo "Error in Part 1"; return; fi
    echo "minQ changed"
    # Run DOS command for BS, DISP, and BS-DISP analyses in turn
    for param_file in iniparams_BS_S_${Site_serial}_F_${Factor_number}_use.txt iniparams_DISP_S_${Site_serial}_F_${Factor_number}_use.txt
    do
      cp ${param_file} iniparams.txt
      if [ $? -ne 0 ]; then echo "Error in Part BS/DISP run"; return; fi
      $DOS_COMMAND
      if [ $? -ne 0 ]; then echo "Error in Part BS/DISP run"; return; fi
      rm iniparams.txt
    done
    # Rename the output from DISP
    mv DISPres1.txt ${dataset}_S_${Site_serial}_F_${Factor_number}_DISPres1.txt
    echo "All runs executed!"
}
function part4_from_DISP {
  echo "Execute from DISP"
    # Run DOS command for BS, DISP, and BS-DISP analyses in turn
    for param_file in iniparams_DISP_S_${Site_serial}_F_${Factor_number}_use.txt
    do
      cp ${param_file} iniparams.txt
      if [ $? -ne 0 ]; then echo "Error in /DISP run"; return; fi
      $DOS_COMMAND
      if [ $? -ne 0 ]; then echo "Error in /DISP run"; return; fi
      rm iniparams.txt
    done
    # Rename the output from DISP
    mv DISPres1.txt ${dataset}_S_${Site_serial}_F_${Factor_number}_DISPres1.txt
    echo "DISP runs executed!"
}
if [ "$use_txt" -eq 2 ] && [ "$BS_size" -gt 10000 ] && [ "$DISPres1_size" -gt 1 ] && [[ "$DISP_size" -gt 10000 ]]; then
    part1_NoRun
fi
if [ "$DISPres1" -eq 1 ] && [ "$DISPres1_size" -eq 0 ]; then
    part4_from_DISP
fi
if [ "$base_txt" -eq 1 ] && [ "$base_task_count" -eq 20 ] && { [ "$BS_size" -lt 10000 ] || [ "$DISP_size" -lt 10000 ]; }; then
    part3_BS_DISP
fi
if [ "$base_txt" -eq 0 ] || [ "$base_task_count" -lt 20 ] || [ "$DISPres1_size" -lt 1 ] || [ "$BS_size" -lt 10000 ] || [ "$DISP_size" -lt 10000 ]; then
    part2_Base
    part3_BS_DISP
fi
exit 0 #terminates the script execution

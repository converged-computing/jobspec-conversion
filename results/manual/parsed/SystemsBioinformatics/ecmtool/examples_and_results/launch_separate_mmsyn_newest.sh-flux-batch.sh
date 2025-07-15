#!/bin/bash
#FLUX: --job-name=ecmtoolmmsyn
#FLUX: -n=20
#FLUX: -t=1800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/scicore/home/nimwegen/degroo0000/ecmtool/lrslib-071a:$LD_LIBRARY_PATH'
export PATH='/scicore/home/nimwegen/degroo0000/ecmtool/lrslib-071a:$PATH'

MODEL_PATH="models/mmsyn_xml_files/mmsyn_sm10.xml"
OUT_PATH="tmp/conversion_cone_mmsyn_sm10.csv"
ADD_OBJ="true"
AUTO_DIRECT="true"
EXT_COMP="None"
HIDE=""
PROHIBIT=""
TAG=""
INPUTS=""
OUTPUTS=""
COMPRESS="true"
HIDE_ALL_IN_OR_OUTPUTS=""
PY_COMMAND="srun --ntasks=1 --nodes=1 python3 main.py"
MPLRS_COMMAND1="mpirun -np ${SLURM_NTASKS} mplrs -redund ecmtool/tmp/mplrs.ine ecmtool/tmp/redund.ine"
MPLRS_COMMAND2="mpirun -np ${SLURM_NTASKS}  mplrs ecmtool/tmp/redund.ine ecmtool/tmp/mplrs.out"
PARALLEL_PY_COMMAND="mpirun -np ${SLURM_NTASKS} python3 main.py"
cd ~/ecmtool
export LD_LIBRARY_PATH=/scicore/home/nimwegen/degroo0000/ecmtool/lrslib-071a:$LD_LIBRARY_PATH
export PATH=/scicore/home/nimwegen/degroo0000/ecmtool/lrslib-071a:$PATH
module purge
module load OpenMPI/4.1.1-GCC-10.3.0
${PY_COMMAND} all_until_mplrs --model_path ${MODEL_PATH} --auto_direction ${AUTO_DIRECT} --hide "${HIDE}" --prohibit "${PROHIBIT}" --tag "${TAG}" --inputs "${INPUTS}" --outputs "${OUTPUTS}" --use_external_compartment "${EXT_COMP}" --add_objective_metabolite "${ADD_OBJ}" --compress "${COMPRESS}" --hide_all_in_or_outputs "${HIDE_ALL_IN_OR_OUTPUTS}" 
${MPLRS_COMMAND1}
${MPLRS_COMMAND2}
${PARALLEL_PY_COMMAND} all_between_mplrs
${MPLRS_COMMAND1}
${MPLRS_COMMAND2}
${PY_COMMAND} all_from_mplrs --out_path ${OUT_PATH}

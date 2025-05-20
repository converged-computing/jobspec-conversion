#!/bin/sh

# Flux job script
#
# Original Slurm script specified partitions: ksu-chem-mri.q, ksu-gen-gpu.q
# In Flux, the queue is typically specified at submission time, e.g.:
# flux submit -q <queue_name> this_script.sh <args...>
# Or, if a specific queue implies specific resources (e.g., GPUs),
# corresponding Flux resource directives could be added here or at submission.
# For example, if running on a GPU queue and GPUs are needed:
# #FLUX: --gpus-per-task=1
#
# This script is intended to be run with command-line arguments.
# If run as part of a multi-task job (analogous to a Slurm job array),
# use 'flux submit --num-tasks=N ...' where N is the number of instances.
# FLUX_TASK_RANK will then correspond to the instance index (0 to N-1).

# Param 1 - ${1}: --bondEn: interaction energy
# Param 2 - ${2}: --iterations: total number of accepted moves
# Param 3 - ${3}: --split: frequency of saving files
# Param 4 - ${4}: --blocks: total blocks in the simulations block
# Param 5 - ${5}: --length: total units in the protein
# Param 6 - ${6}: --Xm
# Param 7 - ${7}: --Ym
# Param 8 - ${8}: --Zm
# Param 10 - ${9}: --dimensions  (Note: Original comment says Param 10, but uses ${9})
# Param 11 - ${10}: --writeId (Note: Original comment says Param 11, but uses ${10})

# --runId: current duplicate job number (provided by FLUX_TASK_RANK)

module load icc

# Ensure PROTEIN_PROJECT_DIR is set in the environment
if [ -z "${PROTEIN_PROJECT_DIR}" ]; then
  echo "Error: PROTEIN_PROJECT_DIR environment variable is not set." >&2
  exit 1
fi

# Check if the program exists and is executable
if [ ! -x "${PROTEIN_PROJECT_DIR}/program.o" ]; then
  echo "Error: Program ${PROTEIN_PROJECT_DIR}/program.o not found or not executable." >&2
  exit 1
fi

${PROTEIN_PROJECT_DIR}/program.o --bondEn ${1} --iterations ${2} --split ${3} --blocks ${4} --length ${5} --runId ${FLUX_TASK_RANK:-0} \
    --Xm ${6:-200} --Ym ${7:-500} --Zm ${8:-200} --dimensions ${9:-4} --writeId ${10:-1}
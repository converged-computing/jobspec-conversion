#!/bin/bash
#FLUX: --job-name=receptor_relax
#FLUX: --queue=standard
#FLUX: -t=216000
#FLUX: --urgency=16

RECEPTOR=${1}
RECEPTOR_JOB_NAME=${2}
SCRATCH_DIR=${OUT}/${RECEPTOR_JOB_NAME}
mkdir ${SCRATCH_DIR}
mkdir ${SCRATCH_DIR}/out_files
mkdir ${SCRATCH_DIR}/pdbs
mkdir ${SCRATCH_DIR}/log_files
cat >${PROJ_DIR}/rosetta_runs/receptor_relax_runs/${RECEPTOR_JOB_NAME}/sbatch_scripts/receptor_fastrelax.sbatch <<-EOF
set -euo pipefail
module load gcc/4.8.5
JOB_ID=$SLURM_JOB_ID
TASK_ID=$SLURM_ARRAY_TASK_ID
PATH_TO_ROSETTA=/home/limcaoco/rosetta/rosetta3.12
SCRATCH_JOB=${SCRATCH_DIR}/${RECEPTOR_JOB_NAME}
${PATH_TO_ROSETTA}/main/source/bin/rosetta_scripts.default.linuxgccrelease \
    -database ${PATH_TO_ROSETTA}/main/database \
    -parser:protocol ${ROSETTA_DOCK}/scripts/rosetta_xml_scripts/receptor_fastrelax.xml \
    -overwrite \
    -mistakes:restore_pre_talaris_2013_behavior true \
    -in:file:s ${PROJ_DIR}/input_files/unrelaxed_receptors/${RECEPTOR}/${RECEPTOR}.pdb\
    -run:jran \${JOB_ID} \
    -out:nstruct 10 \
    -out:prefix \${JOB_ID}_\${TASK_ID}_ \
    -out:file:silent ${SCRATCH_DIR}/out_files/${RECEPTOR}_\${JOB_ID}_\${TASK_ID}.out \
    > ${SCRATCH_DIR}/log_files/${RECEPTOR}_\${JOB_ID}.log
command 2> ${SCRATCH_DIR}/${RECEPTOR}_\${JOB_ID}.err
command 1> ${SCRATCH_DIR}/${RECEPTOR}_\${JOB_ID}.txt
EOF
cat > ${PROJ_DIR}/rosetta_runs/receptor_relax_runs/${RECEPTOR_JOB_NAME}/1_run.sh <<-EOF 
sbatch receptor_fastrelax.sbatch
echo "Submitting job ${SLURM_JOB_ID} to the SLURM cluster"
echo "check status with squeue -u username"
echo "possible errors will be found in FastRelax.log and ROSETTACRASH.log"
EOF
cat > ${PROJ_DIR}/rosetta_runs/receptor_relax_runs/${RECEPTOR_JOB_NAME}/2_collect.sh <<-EOF 
cd ${SCRATCH_DIR}/pdbs
bash ${ROSETTA_DOCK}/scripts/get_pdbs_adv.sh -top -total_score
mv ./pdbs/*.pdb ${PROJ_DIR}/intermediate_files/relaxed_receptors/${RECEPTOR}/${RECEPTOR}.pdb
echo "relaxed receptor file is now located in: intermediate_files/relaxed_receptors/"
cd ${PROJ_DIR}
EOF 

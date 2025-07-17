#!/bin/bash
#FLUX: --job-name=apoa1benchmark
#FLUX: -t=1800
#FLUX: --urgency=16

declare -r SCRATCH_DIR=__SCRATCHSPACE__
declare -r NAMD2_BINARY=__NAMD2BINARY__
declare -r NAMD3_BINARY=__NAMD3BINARY__
declare -r NAMD_RESULTS_DIR=__NAMDRESULTSDIR__
declare -r INPUT_FILES_PARENT_DIR=__APOA1_INPUT_FILES_PARENT_DIR__
declare -ri number_physical_nodes=${SLURM_JOB_NUM_NODES}
declare -r pe_com_map="+commap 0,16,32,48 +pemap 1-15+16+32+48"
cp ${NAMD2_BINARY} ${SCRATCH_DIR}/
cp ${NAMD3_BINARY} ${SCRATCH_DIR}/
input_files=( "apoa1.pdb"
              "apoa1.psf"
              "par_all22_popc.xplor"
              "par_all22_prot_lipid.xplor" ) 
for tmp_input_file in "${input_files[@]}";do
    cp -f "${INPUT_FILES_PARENT_DIR}/${tmp_input_file}" "${SCRATCH_DIR}"
done
cd ${SCRATCH_DIR}/
echo 'charmrun ./namd2 +p2 ./apoa1.namd 1> __STDOUT__ 2> __STDERR__' 
charmrun ./namd3 +p2 ./apoa1.namd  1> __STDOUT__ 2> __STDERR__
cp -rf ${SCRATCH_DIR}/* ${NAMD_RESULTS_DIR}/ 

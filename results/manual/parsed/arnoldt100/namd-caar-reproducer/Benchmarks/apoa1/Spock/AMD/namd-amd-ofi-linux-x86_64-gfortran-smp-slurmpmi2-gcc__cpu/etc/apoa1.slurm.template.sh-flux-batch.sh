#!/bin/bash
#FLUX: --job-name=apoa1benchmark
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -t=4200
#FLUX: --urgency=16

declare -r SCRATCH_DIR=__SCRATCHSPACE__
declare -r NAMD_BINARY=__NAMD3BINARY__
declare -r NAMD_RESULTS_DIR=__NAMDRESULTSDIR__
declare -r INPUT_FILES_PARENT_DIR=__APOA1_INPUT_FILES_PARENT_DIR__
declare -ri number_physical_nodes=${SLURM_JOB_NUM_NODES}
declare -ri max_number_charm_logical_nodes_per_physical_node=4
declare -r pe_com_map="+commap 0,16,32,48 +pemap 1-15+16+32+48"
cp ${NAMD_BINARY} ${SCRATCH_DIR}/
input_files=( "apoa1.pdb"
              "apoa1.psf"
              "par_all22_popc.xplor"
              "par_all22_prot_lipid.xplor" ) 
for tmp_input_file in "${input_files[@]}";do
    cp -f "${INPUT_FILES_PARENT_DIR}/${tmp_input_file}" "${SCRATCH_DIR}"
done
cd ${SCRATCH_DIR}/
my_srun_command="srun -N 2 --ntasks 2 --cpus-per-task 3 __NAMD3BINARYNAME__ +ofi_runtime_tcp ++ppn 2 ${pe_com_map} ./apoa1.namd 1> __STDOUT__ 2> __STDERR__"
echo "srun command: ${my_srun_command}"
eval ${my_srun_command}
cp -rf ${SCRATCH_DIR}/* ${NAMD_RESULTS_DIR}/ 

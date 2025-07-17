#!/bin/bash
#FLUX: --job-name=milky-kitty-0979
#FLUX: -c=8
#FLUX: --queue=REQUESTED_PARTITION
#FLUX: -t=90
#FLUX: --urgency=16

itRoot=$(cd ..; pwd)
. "${itRoot}/scripts/commonFunctionsForTests.sh"
binDir="${itRoot}/${BIN_DIR}"
buildDir="${itRoot}/${BUILD_DIR}"
envDir="${itRoot}/${ENV_DIR}"
codeDir="${itRoot}/CodeDir"
logsDir="${itRoot}/${LOGS_DIR}"
scriptsDir="${itRoot}/${SCRIPTS_DIR}"
. ~/.bashrc          > /dev/null 2>&1
. ${envDir}/gchp.env > /dev/null 2>&1
baseOptions="-DCMAKE_BUILD_TYPE=Debug -DRUNDIR='' -DINSTALLCOPY=${binDir}"
head_gchp=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
           git -C "${codeDir}" log --oneline --no-decorate -1)
head_gc=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
          git -C "${codeDir}/src/GCHP_GridComp/GEOSChem_GridComp/geos-chem" \
          log --oneline --no-decorate -1)
head_hco=$(export GIT_DISCOVERY_ACROSS_FILESYSTEM=1; \
           git -C "${codeDir}/src/GCHP_GridComp/HEMCO_GridComp/HEMCO" \
           log --oneline --no-decorate -1)
scheduler="none"
[[ "x${SLURM_JOBID}" != "x" ]] && scheduler="SLURM"
[[ "x${LSB_JOBID}"   != "x" ]] && scheduler="LSF"
if [[ "x${scheduler}" == "xSLURM" ]]; then
    #-----------------------
    # SLURM settings
    #-----------------------
    # Set OMP_NUM_THREADS to the same # of cores requested with #SBATCH -c
    export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
elif [[ "x${scheduler}" == "xLSF" ]]; then
    #-----------------------
    # LSF settings
    #-----------------------
    # Set OMP_NUM_THREADS to the same # of cores requested with #BSUB -n
    export OMP_NUM_THREADS=${$LSB_DJOB_NUMPROC}
else
    #-----------------------
    # Interactive settings
    #-----------------------
    # For AWS, set $OMP_NUM_THREADS to the available cores
    kernel=$(uname -r)
    [[ "x${kernel}" == "xaws" ]] && export OMP_NUM_THREADS=$(nproc)
fi
[[ "x${OMP_NUM_THREADS}" == "x" ]] && export OMP_NUM_THREADS=6
[[ "x${OMP_STACKSIZE}" == "x" ]] && export OMP_STACKSIZE=500m
numTests=${#EXE_GCHP_BUILD_LIST[@]}
results="${logsDir}/results.compile.log"
rm -f "${results}"
print_to_log "${SEP_MAJOR}"                               "${results}"
print_to_log "GCHP: Compilation Test Results"             "${results}"
print_to_log ""                                           "${results}"
print_to_log "GCHP      #${head_gchp}"                    "${results}"
print_to_log "GEOS-Chem #${head_gc}"                      "${results}"
print_to_log "HEMCO     #${head_hco}"                     "${results}"
print_to_log ""                                           "${results}"
print_to_log "Number of compilation tests: ${numTests}"   "${results}"
print_to_log ""                                           "${results}"
if [[ "x${scheduler}" == "xSLURM" ]]; then
    print_to_log "Submitted as SLURM job: ${SLURM_JOBID}" "${results}"
elif  [[ "x${scheduler}" == "xLSF" ]]; then
    print_to_log "Submitted as LSF job: ${LSB_JOBID}"     "${results}"
else
    print_to_log "Submitted as interactive job"           "${results}"
fi
print_to_log "${SEP_MAJOR}"                               "${results}"
print_to_log " "                   "${results}"
print_to_log "Compiliation tests:" "${results}"
print_to_log "${SEP_MINOR}"        "${results}"
cd "${itRoot}"
let passed=0
let failed=0
let remain=${numTests}
for dir in ${EXE_GCHP_BUILD_LIST[@]}; do
    # Define build directory
    thisBuildDir="${buildDir}/${dir}"
    # Define log file
    log="${logsDir}/compile.${dir}.log"
    rm -f "${log}"
    # Configure and build GEOS-Chem source code
    # and increment pass/fail/remain counters
    build_model "gchp"           "${itRoot}" "${thisBuildDir}" \
                "${baseOptions}" "${log}"    "${results}"
    if [[ $? -eq 0 ]]; then
        let passed++
    else
        let failed++
    fi
    let remain--
done
print_to_log " "                                           "${results}"
print_to_log "Summary of compilation test results:"        "${results}"
print_to_log "${SEP_MINOR}"                                "${results}"
print_to_log "Complilation tests passed:        ${passed}" "${results}"
print_to_log "Complilation tests failed:        ${failed}" "${results}"
print_to_log "Complilation tests not completed: ${remain}" "${results}"
if [[ "x${passed}" == "x${numTests}" ]]; then
    #---------------------------
    # Successful compilation
    #---------------------------
    print_to_log ""                                        "${results}"
    print_to_log "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" "${results}"
    print_to_log "%%%  All compilation tests passed!  %%%" "${results}"
    print_to_log "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" "${results}"
    # Run execution tests interactively
    # (This job has already been submitted as a dependency in SLURM/LSF)
    if [[ "x${scheduler}" == "xnone" ]]; then
        echo ""
        echo "Compilation tests finished!"
        ${scriptsDir}/integrationTestExecute.sh &
    fi
else
    #---------------------------
    # Unsuccessful compilation
    #---------------------------
    if [[ "x${scheduler}" == "xnone" ]]; then
       echo ""
       echo "Compilation tests failed!  Exiting..."
    fi
fi
unset baseOptions
unset binDir
unset buildDir
unset codeDir
unset failed
unset dir
unset envDir
unset head_gcc
unset head_gc
unset head_hco
unset itRoot
unset kernel
unset log
unset logsDir
unset numTests
unset passed
unset remain
unset results
unset scriptsDir
unset scheduler
unset FILL
unset SEP_MAJOR
unset SEP_MINOR
unset CMP_PASS_STR
unset CMP_FAIL_STR
unset EXE_PASS_STR
unset EXE_FAIL_STR

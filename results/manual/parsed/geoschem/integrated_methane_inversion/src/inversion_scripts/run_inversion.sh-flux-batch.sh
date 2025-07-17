#!/bin/bash
#FLUX: --job-name=quirky-lizard-6354
#FLUX: --urgency=16

printf "\n=== PARSING CONFIG FILE ===\n"
invPath={INVERSION_PATH}
configFile={CONFIG_FILE}
source ${invPath}/src/utilities/parse_yaml.sh
eval $(parse_yaml ${invPath}/${configFile})
LonMinInvDomain={LON_MIN}
LonMaxInvDomain={LON_MAX}
LatMinInvDomain={LAT_MIN}
LatMaxInvDomain={LAT_MAX}
nElements={STATE_VECTOR_ELEMENTS}
OutputPath={OUTPUT_PATH}
Res={RES}
SpinupDir="${OutputPath}/${RunName}/spinup_run"
JacobianRunsDir="${OutputPath}/${RunName}/jacobian_runs"
PosteriorRunDir="${OutputPath}/${RunName}/posterior_run"
StateVectorFile={STATE_VECTOR_PATH}
GCDir="./data_geoschem"
JacobianDir="./data_converted"
sensiCache="./data_sensitivities"
tropomiCache="${OutputPath}/${RunName}/data_TROPOMI"
FirstSimSwitch=true
printf "\n=== EXECUTING RUN_INVERSION.SH ===\n"
if [[ ! -d ${JacobianRunsDir} ]]; then
    printf "${JacobianRunsDir} does not exist. Please fix JacobianRunsDir in run_inversion.sh.\n"
    exit 1
fi
if [[ ! -f ${StateVectorFile} ]]; then
    printf "${StateVectorFile} does not exist. Please fix StateVectorFile in run_inversion.sh.\n"
    exit 1
fi
if ! "$PrecomputedJacobian"; then
    printf "Calling postproc_diags.py, FSS=$FirstSimSwitch\n"
    if "$FirstSimSwitch"; then
        if [[ ! -d ${SpinupDir} ]]; then
        printf "${SpinupDir} does not exist. Please fix SpinupDir or set FirstSimSwitch to False in run_inversion.sh.\n"
        exit 1
        fi
        PrevDir=$SpinupDir
    else
        PrevDir=%$PosteriorRunDir
        if [[ ! -d ${PosteriorRunDir} ]]; then
        printf "${PosteriorRunDir} does not exist. Please fix PosteriorRunDir in run_inversion.sh.\n"
        exit 1
        fi
    fi
    printf "  - Hour 0 for ${StartDate} will be obtained from ${PrevDir}\n"
    python postproc_diags.py $RunName $JacobianRunsDir $PrevDir $StartDate; wait
    printf "DONE -- postproc_diags.py\n\n"
fi
if ! "$PrecomputedJacobian"; then
    # 50% perturbation
    Perturbation=0.5
    printf "Calling calc_sensi.py\n"
    python calc_sensi.py $nElements $Perturbation $StartDate $EndDate $JacobianRunsDir $RunName $sensiCache; wait
    printf "DONE -- calc_sensi.py\n\n"
fi
if ! "$PrecomputedJacobian"; then
    GCsourcepth="${JacobianRunsDir}/${RunName}_0000/OutputDir"
    printf "Calling setup_gc_cache.py\n"
    python setup_gc_cache.py $StartDate $EndDate $GCsourcepth $GCDir; wait
    printf "DONE -- setup_gc_cache.py\n\n"
fi
if ! "$PrecomputedJacobian"; then
    printf "Calling jacobian.py\n"
    isPost="False"
    python jacobian.py $StartDate $EndDate $LonMinInvDomain $LonMaxInvDomain $LatMinInvDomain $LatMaxInvDomain $nElements $tropomiCache $isPost; wait
    printf " DONE -- jacobian.py\n\n"
fi
posteriorSF="./inversion_result.nc"
printf "Calling invert.py\n"
python invert.py $nElements $JacobianDir $posteriorSF $LonMinInvDomain $LonMaxInvDomain $LatMinInvDomain $LatMaxInvDomain $PriorError $ObsError $Gamma $Res; wait
printf "DONE -- invert.py\n\n"
GriddedPosterior="./gridded_posterior.nc"
printf "Calling make_gridded_posterior.py\n"
python make_gridded_posterior.py $posteriorSF $StateVectorFile $GriddedPosterior; wait
printf "DONE -- make_gridded_posterior.py\n\n"
exit 0

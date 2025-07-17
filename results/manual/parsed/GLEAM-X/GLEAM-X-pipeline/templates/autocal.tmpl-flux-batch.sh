#!/bin/bash
#FLUX: --job-name=placid-lettuce-4069
#FLUX: -t=7200
#FLUX: --urgency=16

export FI_CXI_DEFAULT_VNI='$(od -vAn -N4 -tu < /dev/urandom)'

set -x
pipeuser=PIPEUSER
obsnum=OBSNUM
echo $SLURM_MEM_PER_NODE
if [[ -f "${obsnum}" ]]
then
    taskid=${SLURM_ARRAY_TASK_ID}
    jobid=${SLURM_ARRAY_JOB_ID}
    echo "obsfile ${obsnum}"
    obsnum=$(sed -n -e "${SLURM_ARRAY_TASK_ID}"p "${obsnum}")
    echo "autocal obsid ${obsnum}"
else
    taskid=1
    jobid=${SLURM_JOB_ID}
fi
echo "jobid: ${jobid}"
echo "taskid: ${taskid}"
function test_fail {
if [[ $1 != 0 ]]
then
    singularity run ${GXCONTAINER} track_task.py fail --jobid="${jobid}" --taskid="${taskid}" --finish_time="$(date +%s)"
    exit "$1"
fi
}
datadir=DATADIR
if [[ $obsnum -gt 1300000000 ]] && [[ $obsnum -lt 1342950000 ]]
then
    refant=0
elif [[ $obsnum -gt 1342950000 ]]
then
    refant=8
else
    refant=127
fi
fraction=FRACTION
sthresh=STHRESH
catfile="${GXBASE}/models/GGSM.txt"
MWAPATH="${GXMWAPB}"
minuv=75
ion=IONOTEST
ts=10
singularity run ${GXCONTAINER} track_task.py start --jobid="${jobid}" --taskid="${taskid}" --start_time="$(date +%s)"
cd "${datadir}/${obsnum}" || exit
metafits="${obsnum}.metafits"
if [[ ! -e ${metafits} ]] || [[ ! -s ${metafits} ]]
then
    wget -O "${metafits}" http://ws.mwatelescope.org/metadata/fits?obs_id=${obsnum}
    test_fail $?
fi
calibrator=$(singularity run $GXCONTAINER pyhead.py -p CALIBSRC "$metafits" | awk '{print $3}' )
echo "Calibrator is $calibrator"
echo "Running infield calibration for $obsnum"
RA=$(singularity run $GXCONTAINER pyhead.py -p RA "$metafits" | awk '{print $3}' )
Dec=$(singularity run $GXCONTAINER pyhead.py -p DEC "$metafits" | awk '{print $3}' )
chan=$(singularity run $GXCONTAINER pyhead.py -p CENTCHAN "$metafits" | awk '{print $3}' )
if [[ ! -e "${obsnum}_local_gleam_model.txt" ]]
then
    ln -s ${catfile} "${obsnum}_local_gleam_model.txt"
fi
calmodel="${obsnum}_local_gleam_model.txt"
cd "${datadir}/${obsnum}" || exit
current=$(singularity run $GXCONTAINER chgcentre "${obsnum}.ms") 
if [[ $current == *"shift"* ]] 
then
    echo "Detected that this measurement set has undergone a denormal shift; this must be undone before calibration."
    coords=$(singularity run $GXCONTAINER calc_optimum_pointing.py --metafits "${metafits}")
    echo "Optimally shifting co-ordinates of measurement set to $coords, without zenith shiftback."
    srun singularity run ${GXCONTAINER} chgcentre \
            "${obsnum}.ms" \
            ${coords}
else
    echo "Detected that this measurement set has not yet had its phase centre changed. Not shifting."
fi
minuvm=$(echo "234 * ${minuv} / ${chan}" | bc -l)
maxuvm=$(echo "390000 / (${chan} + 11)" | bc -l)
if [[ ! -z $ion ]]
then
    echo "Performing ionospheric triage. "
    # Ionospheric triage
    solutions1="${obsnum}_${calmodel%%.txt}_solutions_ts10.bin"
    # Remove duplicate obsnum
    solutions1="${solutions1/${obsnum}_${obsnum}_/${obsnum}_}"
    export FI_CXI_DEFAULT_VNI=$(od -vAn -N4 -tu < /dev/urandom)
    srun -N 1 -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK -m block:block:block singularity run $GXCONTAINER hyperdrive \
        di-calibrate \
        --max-iterations 500 \
        --timesteps {0..9} \
        --num-sources 1000 \
        --uvw-min "${minuv}lambda" \
        --uvw-max 1667lambda \
        --beam-file "${MWAPATH}/mwa_full_embedded_element_pattern.h5" \
        --outputs "${solutions1}" \
        -d "${obsnum}.ms" "${obsnum}.metafits" \
        -s ${calmodel}
    singularity run $GXCONTAINER hyperdrive \
        solutions-plot \
        --ref-tile ${refant} \
        --max-amp 2 \
        -m ${obsnum}.metafits \
        "${solutions1}" 
    solutions="${obsnum}_${calmodel%%.txt}_solutions_ts20.bin"
    # Remove duplicate obsnum
    solutions="${solutions/${obsnum}_${obsnum}_/${obsnum}_}"
    export FI_CXI_DEFAULT_VNI=$(od -vAn -N4 -tu < /dev/urandom)
    srun -N 1 -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK -m block:block:block singularity run $GXCONTAINER hyperdrive \
        di-calibrate \
        --timesteps {10..19} \
        --max-iterations 500 \
        --num-sources 1000 \
        --uvw-min "${minuv}lambda" \
        --uvw-max 1667lambda \
        --beam-file "${MWAPATH}/mwa_full_embedded_element_pattern.h5" \
        --outputs "${solutions}" \
        -d "${obsnum}.ms" "${obsnum}.metafits" \
        -s ${calmodel}
    singularity run $GXCONTAINER hyperdrive \
        solutions-plot \
        --ref-tile ${refant} \
        --max-amp 2 \
        -m ${obsnum}.metafits \
        "${solutions}" 
    solutions="${obsnum}_${calmodel%%.txt}_solutions_ts30.bin"
    # Remove duplicate obsnum
    solutions="${solutions/${obsnum}_${obsnum}_/${obsnum}_}"
    export FI_CXI_DEFAULT_VNI=$(od -vAn -N4 -tu < /dev/urandom)
    srun -N 1 -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK -m block:block:block singularity run $GXCONTAINER hyperdrive \
        di-calibrate \
        --timesteps {20..29} \
        --max-iterations 500 \
        --num-sources 1000 \
        --uvw-min "${minuv}lambda" \
        --uvw-max 1667lambda \
        --beam-file "${MWAPATH}/mwa_full_embedded_element_pattern.h5" \
        --outputs "${solutions}" \
        -d "${obsnum}.ms" "${obsnum}.metafits" \
        -s ${calmodel}
    singularity run $GXCONTAINER hyperdrive \
        solutions-plot \
        --ref-tile ${refant} \
        --max-amp 2 \
        -m ${obsnum}.metafits \
        "${solutions}" 
    echo "Ionospheric calibration finished. Creating plots and statistics. "
    singularity run ${GXCONTAINER} python ${GXBASE}/gleam_x/bin/aocal_diff.py --metafits="${metafits}" --names --lastsol "${solutions}" "${solutions1}" --refant="${refant}"
    singularity run ${GXCONTAINER} iono_update.py --ionocsv "${obsnum}_ionodiff.csv"
fi
solutions="${obsnum}_${calmodel%%.txt}_solutions_initial.bin"
solutions="${solutions/${obsnum}_${obsnum}_/${obsnum}_}"
export FI_CXI_DEFAULT_VNI=$(od -vAn -N4 -tu < /dev/urandom)
srun -N 1 -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK -m block:block:block singularity run $GXCONTAINER hyperdrive \
    di-calibrate \
    --uvw-min "${minuv}lambda" \
    --max-iterations 500 \
    --num-sources 1000 \
    --uvw-max 1667lambda \
    --beam-file "${MWAPATH}/mwa_full_embedded_element_pattern.h5" \
    --outputs "${solutions}" \
    -d "${obsnum}.ms" "${obsnum}.metafits" \
    -s ${calmodel}
test_fail $?
singularity run ${GXCONTAINER} aocal_phaseref.py "${solutions}" "${solutions%.bin}_ref.bin" "${refant}" --xy -2.806338586067941065e+01 --dxy -4.426533296449057023e-07  --ms "${obsnum}.ms"
singularity run $GXCONTAINER hyperdrive \
    solutions-plot \
    --ref-tile ${refant} \
    --max-amp 2 \
    -m ${obsnum}.metafits \
    "${solutions%.bin}_ref.bin" 
test_fail $?
result=$(singularity run $GXCONTAINER check_assign_solutions.py -t "${fraction}" check "${solutions%.bin}_ref.bin")
if echo "${result}" | grep -q fail
then
    mv "${solutions%.bin}_ref.bin" "${solutions%.bin}_ref_failed.bin"
    test_fail 1
fi
singularity run ${GXCONTAINER} track_task.py finish --jobid="${jobid}" --taskid="${taskid}" --finish_time="$(date +%s)"

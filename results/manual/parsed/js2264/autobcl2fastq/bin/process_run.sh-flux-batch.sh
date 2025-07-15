#!/bin/bash
#FLUX: --job-name=phat-truffle-5812
#FLUX: -c=20
#FLUX: --urgency=16

module purge
module load bcl2fastq/2.20.0
module load graalvm/ce-java8-20.0.0
module load fastqc/0.11.9
module load bowtie2/2.1.0
module load MultiQC/1.9
RUNDATE=`echo "${RUN}" | sed 's,_.*,,g'`
RUNNB=`echo "${RUN}" | sed 's,.*_\([0-9][0-9][0-9][0-9]\)_.*,\1,g'`
RUNHASH=`echo "${RUN}" | sed 's,.*_,,g'`
RUNID="${RUNNB}_${RUNDATE}_${RUNHASH}"
function fn_log {
    echo -e "`date "+%y-%m-%d %H:%M:%S"` [INFO] $@"
}
function cleanup() {
    local status=$?
    if ( test "${status}" -gt 0 ) ; then
        echo "Caught signal ${status} ... cleaning up & quitting."
        rm -f ${WORKING_DIR}/PROCESSING
        exit 1
    fi
    exit 0
}
trap cleanup EXIT INT TERM
fn_log "Fetching sequencing run data"
mkdir -p "${WORKING_DIR}"/runs
rsync "${SSH_HOSTNAME}":"${SOURCE}"/"${RUN}"/ "${WORKING_DIR}"/runs/"${RUNID}"/ --recursive
fn_log "Running bcl2fastq"
mkdir -p "${WORKING_DIR}"/fastq/"${RUNID}"/
bcl2fastq \
    --no-lane-splitting \
    -R "${WORKING_DIR}"/runs/"${RUNID}"/ \
    -o "${WORKING_DIR}"/fastq/"${RUNID}"/ \
    --sample-sheet "${WORKING_DIR}"/samplesheets/SampleSheet_"${RUNNB}"_"${RUNDATE}"_"${RUNHASH}".csv \
    --loading-threads 6 \
    --processing-threads 6 \
    --writing-threads 6
cp "${WORKING_DIR}"/samplesheets/SampleSheet_"${RUNNB}"_"${RUNDATE}"_"${RUNHASH}".csv "${WORKING_DIR}"/fastq/"${RUNID}"/SampleSheet_"${RUNNB}"_"${RUNDATE}"_"${RUNHASH}".csv
fn_log "Fixing fastq names"
for FILE in `find "${WORKING_DIR}"/fastq/"${RUNID}"/ -iname "*.fastq.gz"`
do
    newfile=`echo ${FILE} | sed -e 's,_001.fastq.gz,.fq.gz,' | sed -e 's,_S[0-9]_R,_nxq_R,' | sed -e 's,_S[0-9][0-9]_R,_nxq_R,'`
    mv "${FILE}" "${newfile}"
done
fn_log "Running FastQC"
mkdir -p "${WORKING_DIR}"/fastqc/"${RUNID}"
fastqc \
    --outdir "${WORKING_DIR}"/fastqc/"${RUNID}" \
    --noextract \
    --threads 12 \
    --adapters "${BASE_DIR}"/adapters.txt \
    "${WORKING_DIR}"/fastq/"${RUNID}"/*/*fq.gz 1>&2
fn_log "Running fastq_screen"
mkdir -p "${WORKING_DIR}"/fastqscreen/"${RUNID}"
fastq_screen \
    --outdir "${WORKING_DIR}"/fastqscreen/"${RUNID}" \
    --conf "${BASE_DIR}"/fastq_screen.conf \
    --threads 12 \
    "${WORKING_DIR}"/fastq/"${RUNID}"/*/*fq.gz
fn_log "Running multiqc"
mkdir -p "${WORKING_DIR}"/multiqc/"${RUNID}"
multiqc \
    --title "${RUNID}" \
    --outdir "${WORKING_DIR}"/multiqc/"${RUNID}" \
    --force \
    --verbose \
    --module bcl2fastq \
    --module fastq_screen \
    --module fastqc \
    "${WORKING_DIR}"/fastq/"${RUNID}" \
    "${WORKING_DIR}"/fastqc/"${RUNID}" \
    "${WORKING_DIR}"/fastqscreen/"${RUNID}" 1>&2
fn_log "Exporting fastq reads"
rsync "${WORKING_DIR}"/fastq/"${RUNID}"/ "${SSH_HOSTNAME}":"${DESTINATION}"/run_"${RUNID}"/ --recursive
rsync "${WORKING_DIR}"/multiqc/"${RUNID}"/"${RUNID}"_multiqc_report.html "${SSH_HOSTNAME}":"${DESTINATION}"/run_"${RUNID}"/MultiQC_"${RUNID}".html
ssh "${SSH_HOSTNAME}" touch "${DESTINATION}"/run_"${RUNID}"/DONE
ssh "${SSH_HOSTNAME}" chmod -R u=rwX,g=rwX,o=rX "${DESTINATION}"/run_"${RUNID}"
echo "Files stored in ${DESTINATION}"/run_"${RUNID}" | mailx \
    -s "[CLUSTER INFO] Finished processing run ${RUNID} with autobcl2fastq" \
    -a "${WORKING_DIR}"/samplesheets/SampleSheet_"${RUNNB}"_"${RUNDATE}"_"${RUNHASH}".csv \
    -a "${WORKING_DIR}"/multiqc/"${RUNID}"/"${RUNID}"_multiqc_report.html \
    ${EMAIL}
fn_log "Cleaning up big files"
rm -r "${WORKING_DIR}"/runs/"${RUNID}"/
rm -r "${WORKING_DIR}"/fastq/"${RUNID}"/
rm "${WORKING_DIR}"/PROCESSING
fn_log "Done!"
exit 0

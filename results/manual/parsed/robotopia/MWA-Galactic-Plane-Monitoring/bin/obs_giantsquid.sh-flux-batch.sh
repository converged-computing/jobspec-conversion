#!/bin/bash
#FLUX: --job-name=carnivorous-truffle-5761
#FLUX: --queue=${PARTITION}
#FLUX: --urgency=16

export SINGULARITY_BINDPATH='${SINGULARITY_BINDPATH}'

time_request="02:00:00"
usage()
{
echo "obs_giantsquid.sh [-p project] [-d depend] [-t] obsid [obsid ...]
-d depend         : job number for dependency (afterok)
-p project        : project, (must be specified, no default)
-t                : test. Don't submit job, just make the batch file
and then return the submission command
-T                : override the default SLURM time request  (${time_request})
-f                : Force re-download (default is to ignore obsids
if the measurement set already exists).
-o obsid_file     : the path to a file containing obsid(s) to process" 1>&2;
}
pipeuser=${GPMUSER}
depend=
tst=
force=
while getopts ':tT:hd:p:o:f' OPTION
do
case "$OPTION" in
d)
depend="--dependency=afterok:${OPTARG}" ;;
p)
project=${OPTARG} ;;
t)
tst=1 ;;
T)
time_request="${OPTARG}" ;;
f)
force=1 ;;
o)
obsid_file=${OPTARG} ;;
? | : | h)
usage; exit 0 ;;
esac
done
if [[ -z $obsid_file ]]
then
echo "ObsID file (-o) must be supplied"
usage
exit 1;
fi
obsids="$(cat "$obsid_file" | xargs)"
if [[ -z $obsids ]]
then
echo "No obsids supplied. Nothing to be done."
exit 0
fi
if [[ -z $project ]]
then
echo "Project (-p) must be supplied"
usage
exit 1;
fi
base="${GPMSCRATCH}/${project}"
mkdir -p "$base"
cd "${base}"
if [[ -z $force ]] # i.e. if the -f option was NOT supplied
then
filtered_obsids=
for obsid in $obsids
do
ms="$obsid/$obsid.ms"
if [[ ! -d $ms ]] # If the measurement set does NOT exist
then
filtered_obsids="$filtered_obsids $obsid"
else
echo "Obs ${obsid} already has measurement set on disk. Skipping."
fi
done
obsids="$filtered_obsids"
else
echo "Force option chosen. DANGER! Existing measurement sets will now be deleted!!"
for obsid in $obsids
do
cd "${base}/${obsid}"
rm -rf "$obsid.ms"
done
fi
asvo_json=$(singularity exec $GPMCONTAINER giant-squid list ${obsids} --json)
preprocess_obsids=
download_obsids=
for obsid in $obsids
do
states=($(echo "$asvo_json" | singularity exec $GPMCONTAINER jq -r ".[]| select( .obsid == ${obsid} ).jobState")) # use an array in case there are more than one
state=${states[0]} # Just grab the first state
if [[ $state == "Ready" ]]
then
echo "Obs ${obsid} ready for download. Adding it to the download list"
download_obsids="$download_obsids $obsid"
elif [[ $state == "Processing" || $state == "Queued" ]]
then
echo "Obs ${obsid} is already being processed on ASVO. Skipping."
elif [[ $state == "Cancelled" || $state == "Expired" || $state == "Error" ]]
then
echo "Obs ${obsid} was previously in state \"${state}\". Will submit fresh preprocessing job for this obs."
preprocess_obsids="$preprocess_obsids $obsid"
else
echo "Obs ${obsid} is not in your ASVO job list. Adding it to the preprocessing list"
preprocess_obsids="$preprocess_obsids $obsid"
fi
done
if [[ $(echo "$preprocess_obsids" | wc -w) -ge 1 ]]
then
echo "==================================="
echo "Preprocessing list: ${preprocess_obsids}"
if [[ ! -z ${tst} ]]
then
echo "Test mode active: Command that would be run is:"
echo
echo "singularity exec $GPMCONTAINER giant-squid submit-conv -p avg_time_res=4,avg_freq_res=40,flag_edge_width=80,output=ms $preprocess_obsids"
echo
else
singularity exec $GPMCONTAINER giant-squid submit-conv -p avg_time_res=4,avg_freq_res=40,flag_edge_width=80,output=ms $preprocess_obsids
echo
echo "Preprocessing jobs sent to ASVO"
fi
else
echo "No preprocessing jobs sent"
fi
if [[ $(echo "$download_obsids" | wc -w) -ge 1 ]]
then
echo "==================================="
echo "Download list: ${download_obsids}"
timestamp=$(date +"%Y%m%d_%H%M%S")
script="${GPMSCRIPT}/giantsquid_download_${timestamp}.sh"
cat "${GPMBASE}/templates/giantsquid_download.tmpl" > "${script}"
chmod 755 "${script}"
sbatch_script="${script%.sh}.sbatch"
BEGIN="now+1minutes"
MEM="50G"
EXPORT="$(echo ${!GPM*} | tr ' ' ','),MWA_ASVO_API_KEY"
TIME="${time_request}"
CLUSTERS="${GPMCOPYM}"
OUTPUT="${GPMLOG}/giantsquid_download_${timestamp}.o%A-%j"
ERROR="${GPMLOG}/giantsquid_download_${timestamp}.e%A"
PARTITION="${GPMCOPYQ}"
ACCOUNT="${GPMACCOUNT}"
ARRAY="$(echo "$download_obsids" | xargs | tr ' ' ',')" # turn into whitespace-trimmed, comma-separated list
if [[ ! -z $GPMCOPYA ]]
then
ACCOUNT="--account=${GPMCOPYA}"
fi
echo "#!/bin/bash
module load singularity/3.7.4
obsids=\"${download_obsids}\"
obsid=\$(echo \$obsids | cut -d \" \" -f \$SLURM_ARRAY_TASK_ID)
singularity run ${GPMCONTAINER} ${script} \$obsid
" >> "${sbatch_script}"
sub="sbatch ${depend} --export="${EXPORT}" ${sbatch_script}"
if [[ ! -z ${tst} ]]
then
echo "script is ${script}"
echo "submit via:"
echo "${sub}"
else
jobid=($(${sub}))
jobid=${jobid[3]}
error="${error//%A/${jobid[0]}}"
output="${output//%A/${jobid[0]}}"
n=1
for obsid in $obsids
do
if [ "${GPMTRACK}" = "track" ]
then
${GPMCONTAINER} track_task.py queue --jobid="${jobid[0]}" --taskid="${n}" --task='download' --submission_time="$(date +%s)" \
--batch_file="${script}" --obs_id="${obsid}" --stderr="${error}" --stdout="${output}"
fi
((n+=1))
done
echo "Submitted ${script} as ${jobid} . Follow progress here:"
echo "${output}"
echo "${error}"
fi
else
echo "No download jobs sent"
fi

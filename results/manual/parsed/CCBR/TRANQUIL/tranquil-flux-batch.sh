#!/bin/bash
#FLUX: --job-name=TRANQUIL
#FLUX: -c=2
#FLUX: --queue=norm
#FLUX: -t=345600
#FLUX: --urgency=16

export PATH='/mnt/projects/CCBR-Pipelines/bin/:${PATH}'

set -eo pipefail
module purge
PYTHON_VERSION="python/3.7"
SNAKEMAKE_VERSION="snakemake/5.24.1"
if [ "$HOSTNAME" == "biowulf.nih.gov" ]; then
  HOST="BIOWULF"
elif [ "$HOSTNAME" == "fsitgl-head01p.ncifcrf.gov" ];then
  HOST="FRCE"
fi
if [ "$HOST" == "BIOWULF" ];then
  EXTRA_SINGULARITY_BINDS="/lscratch,/data/CCBR_Pipeliner/"
elif [ "$HOST" == "FRCE" ];then
  EXTRA_SINGULARITY_BINDS="/scratch/cluster_scratch/${USER},/mnt/projects/CCBR-Pipelines"
else
  err Can only run on BIOWULF or FRCE
fi
SCRIPTNAME="$0"
SCRIPTDIRNAME=$(readlink -f $(dirname $0))
SCRIPTBASENAME=$(readlink -f $(basename $0))
function get_git_commitid_tag() {
  cd $1
  gid=$(git rev-parse HEAD)
  tag=$(git describe --tags $gid 2>/dev/null)
  echo -ne "$gid\t$tag"
}
echo "#################################################################"
echo "#################################################################"
PIPELINE_HOME=$(readlink -f $(dirname "$0"))
RESOURCESDIR="$PIPELINE_HOME/resources"
SCRIPTSDIR="$PIPELINE_HOME/workflow/scripts"
echo -ne "Pipeline Dir: \t\t $PIPELINE_HOME\n"
SNAKEFILE="${PIPELINE_HOME}/workflow/Snakefile"
echo -ne "Snakefile: \t\t $SNAKEFILE\n"
VERSION=$(cat ${PIPELINE_HOME}/VERSION)
echo -ne "Version: \t\t $VERSION\n"
echo -ne "Host: \t\t\t $HOST\n"
function usage_only() {
cat << EOF
USAGE:
  bash ${SCRIPTNAME} -m/--runmode=<RUNMODE> -w/--workdir=<WORKDIR>
Required Arguments:
1.  RUNMODE: [Type: String] Valid options:
    *) init : initialize workdir
    *) run : run with slurm
    *) reset : DELETE workdir dir and re-init it
    *) dryrun : dry run snakemake to generate DAG
    *) unlock : unlock workdir if locked by snakemake
    *) runlocal : run without submitting to sbatch
2.  WORKDIR: [Type: String]: Absolute or relative path to the 
             output folder with write permissions.
EOF
}
function usage() { 
cat << EOF
Running ${SCRIPTBASENAME} ...
TRANQUIL (TRna AbundaNce QUantification pIpeLine)
EOF
usage_only
}
function err() { 
cat << EOF
  $@
EOF
usage_only && exit 1 1>&2; 
}
function _set_config() {
sed -e "s/PIPELINE_HOME/${PIPELINE_HOME//\//\\/}/g" \
    -e "s/WORKDIR/${WORKDIR//\//\\/}/g" \
    -e "s/WORKRESOURCESDIR/${WORKRESOURCESDIR//\//\\/}/g" \
    -e "s/WORKSCRIPTSDIR/${WORKSCRIPTSDIR//\//\\/}/g" \
    ${PIPELINE_HOME}/config/config.yaml > $WORKDIR/config.yaml
}
function _set_test_samplemanifest() {
sed -e "s/PIPELINE_HOME/${PIPELINE_HOME//\//\\/}/g" \
    -e "s/WORKDIR/${WORKDIR//\//\\/}/g" \
    ${PIPELINE_HOME}/config/samples.tsv > $WORKDIR/samples.tsv
}
function init() {
if [ -d $WORKDIR ];then err "Folder $WORKDIR already exists!"; fi
mkdir -p $WORKDIR
echo "COPYING resources ..."
if [ ! -d $WORKRESOURCESDIR ];then
  mkdir -p $WORKRESOURCESDIR
  cp -a $RESOURCESDIR/. $WORKRESOURCESDIR/
fi
echo "COPYING scripts ..."
if [ ! -d $WORKSCRIPTSDIR ];then
  mkdir -p $WORKSCRIPTSDIR
  cp -a $SCRIPTSDIR/. $WORKSCRIPTSDIR/
fi
_set_config
_set_test_samplemanifest
cp ${PIPELINE_HOME}/config/contrasts.tsv $WORKDIR/contrasts.tsv
if [ ! -d $WORKDIR/logs ]; then 
  mkdir -p $WORKDIR/logs
  echo -ne "Logs Dir: \t\t $WORKDIR/logs\n"
fi
if [ ! -d $WORKDIR/stats ];then 
  mkdir -p $WORKDIR/stats
  echo -ne "Stats Dir: \t\t $WORKDIR/stats\n"
fi
cat << EOF
Done Initializing $WORKDIR. 
You can now edit 
$WORKDIR/config.yaml
$WORKDIR/samples.tsv
and
$WORKDIR/contrasts.tsv
EOF
}
function check_essential_files() {
  if [ ! -d $WORKDIR ];then err "Folder $WORKDIR does not exist!"; fi
  for f in config.yaml samples.tsv contrasts.tsv ; do
    if [ ! -f $WORKDIR/$f ]; then 
      err "Error: '${f}' file not found in workdir ... initialize first!"
    fi
  done
}
function reconfig(){
  check_essential_files
  _set_config
  echo "$WORKDIR/config.yaml has been updated!"
}
function runcheck(){
  check_essential_files
if [ "$HOST" == "BIOWULF" ]; then
  module load $PYTHON_VERSION
  module load $SNAKEMAKE_VERSION
  module load singularity
elif [ "$HOST" == "FRCE" ];then
  module load singularity/3.7.2 > /dev/null
  # Add my own version of python and snakemake to the PATH
  export PATH=/mnt/projects/CCBR-Pipelines/bin/:${PATH}
fi
}
function dryrun() {
  runcheck
  run "--dry-run"
}
function unlock() {
  runcheck
  run "--unlock"
}
function _exe_in_path() {
  name_of_exe=$1
  path_to_exe=$(which $name_of_exe 2>/dev/null)
 if [ ! -x "$path_to_exe" ] ; then
    err $path_to_exe NOT FOUND!
 fi
}
function set_singularity_binds(){
  _exe_in_path dos2unix
  echo "$PIPELINE_HOME" > ${WORKDIR}/tmp1
  echo "$WORKDIR" >> ${WORKDIR}/tmp1
  grep -o '\/.*' <(cat ${WORKDIR}/config.yaml ${WORKDIR}/samples.tsv)| \
    dos2unix | \
    tr '\t' '\n' | \
    grep -v ' \|\/\/' | \
    sort | \
    uniq >> ${WORKDIR}/tmp1
  grep gpfs ${WORKDIR}/tmp1|awk -F'/' -v OFS='/' '{print $1,$2,$3,$4,$5}' | \
    grep "[a-zA-Z0-9]" | \
    sort | uniq > ${WORKDIR}/tmp2
  grep -v gpfs ${WORKDIR}/tmp1|awk -F'/' -v OFS='/' '{print $1,$2,$3}' | \
    grep "[a-zA-Z0-9]" | \
    sort | uniq > ${WORKDIR}/tmp3
  while read a;do 
    readlink -f $a
  done < ${WORKDIR}/tmp3 | grep "[a-zA-Z0-9]"> ${WORKDIR}/tmp4
  binds=$(cat ${WORKDIR}/tmp2 ${WORKDIR}/tmp3 ${WORKDIR}/tmp4 | sort | uniq | tr '\n' ',')
  rm -f ${WORKDIR}/tmp?
  binds=$(echo $binds | awk '{print substr($1,1,length($1)-1)}')
  SINGULARITY_BINDS="-B $EXTRA_SINGULARITY_BINDS,$binds"
}
function printbinds(){
  set_singularity_binds
  echo $SINGULARITY_BINDS
}
function runlocal() {
  runcheck
  set_singularity_binds
  if [ "$SLURM_JOB_ID" == "" ];then err "runlocal can only be done on an interactive node"; fi
  module load singularity
  run "local"
}
function runslurm() {
  runcheck
  set_singularity_binds
  run "slurm"
}
function _get_file_modtime() {
  filename=$1
  modtime=$(stat $filename|grep Modify|awk '{print $2,$3}'|awk -F"." '{print $1}'|sed "s/ //g"|sed "s/-//g"|sed "s/://g")
  echo $modtime
}
function create_runinfo() {
  if [ -f ${WORKDIR}/runinfo.yaml ];then
    modtime=$(_get_file_modtime ${WORKDIR}/runinfo.yaml)
    mv ${WORKDIR}/runinfo.yaml ${WORKDIR}/stats/runinfo.yaml.${modtime}
  fi
  echo "Pipeline Dir: $PIPELINE_HOME" > ${WORKDIR}/runinfo.yaml
  echo "Git Commit/Tag: $GIT_COMMIT_TAG" >> ${WORKDIR}/runinfo.yaml
  userlogin=$(whoami)
  username=$(pinky -l $userlogin|grep "In real life:"|awk -F"In real life:" '{print $2}')
  echo "Login: $userlogin" >> ${WORKDIR}/runinfo.yaml
  echo "Name: $username" >> ${WORKDIR}/runinfo.yaml
  g=$(groups)
  echo "Groups: $g" >> ${WORKDIR}/runinfo.yaml
  d=$(date)
  echo "Date/Time: $d" >> ${WORKDIR}/runinfo.yaml
  echo "#################################################################" >> ${WORKDIR}/runinfo.yaml
  echo "##########################config.yaml############################" >> ${WORKDIR}/runinfo.yaml
  echo "#################################################################" >> ${WORKDIR}/runinfo.yaml
  cat ${WORKDIR}/config.yaml >> ${WORKDIR}/runinfo.yaml
  echo "#################################################################" >> ${WORKDIR}/runinfo.yaml
  echo "##########################samples.tsv############################" >> ${WORKDIR}/runinfo.yaml
  echo "#################################################################" >> ${WORKDIR}/runinfo.yaml
  cat ${WORKDIR}/samples.tsv >> ${WORKDIR}/runinfo.yaml
  echo "#################################################################" >> ${WORKDIR}/runinfo.yaml
}
function preruncleanup() {
  echo "Running..."
  # check initialization
  check_essential_files 
  cd $WORKDIR
  ## Archive previous run files
  if [ -f ${WORKDIR}/snakemake.log ];then 
    modtime=$(_get_file_modtime ${WORKDIR}/snakemake.log)
    mv ${WORKDIR}/snakemake.log ${WORKDIR}/stats/snakemake.${modtime}.log
    if [ -f ${WORKDIR}/snakemake.log.HPC_summary.txt ];then 
      mv ${WORKDIR}/snakemake.log.HPC_summary.txt ${WORKDIR}/stats/snakemake.${modtime}.log.HPC_summary.txt
    fi
    if [ -f ${WORKDIR}/snakemake.stats ];then 
      mv ${WORKDIR}/snakemake.stats ${WORKDIR}/stats/snakemake.${modtime}.stats
    fi
  fi
  nslurmouts=$(find ${WORKDIR} -maxdepth 1 -name "slurm-*.out" |wc -l)
  if [ "$nslurmouts" != "0" ];then
    for f in $(ls ${WORKDIR}/slurm-*.out);do mv ${f} ${WORKDIR}/logs/;done
  fi
  create_runinfo
}
function run() {
  if [ "$1" == "local" ];then
  preruncleanup
  snakemake -s $SNAKEFILE \
  --directory $WORKDIR \
  --printshellcmds \
  --use-singularity \
  --singularity-args "$SINGULARITY_BINDS" \
  --use-envmodules \
  --latency-wait 120 \
  --configfile ${WORKDIR}/config.yaml \
  --cores all \
  --stats ${WORKDIR}/snakemake.stats \
  2>&1|tee ${WORKDIR}/snakemake.log
  if [ "$?" -eq "0" ];then
    snakemake -s $SNAKEFILE \
    --report ${WORKDIR}/runlocal_snakemake_report.html \
    --directory $WORKDIR \
    --configfile ${WORKDIR}/config.yaml 
  fi
  elif [ "$1" == "slurm" ];then
  preruncleanup
cat > ${WORKDIR}/submit_script.sbatch << EOF
module purge
EOF
if [ "$HOST" == "BIOWULF" ]; then
cat >> ${WORKDIR}/submit_script.sbatch << EOF
module load $PYTHON_VERSION
module load $SNAKEMAKE_VERSION
module load singularity
EOF
elif [ "$HOST" == "FRCE" ];then
cat >> ${WORKDIR}/submit_script.sbatch << EOF
export PATH=/mnt/projects/CCBR-Pipelines/bin/:${PATH}
module load singularity/3.10.5
EOF
fi
cat >> ${WORKDIR}/submit_script.sbatch << EOF
cd \$SLURM_SUBMIT_DIR
snakemake -s $SNAKEFILE \\
--directory $WORKDIR \\
--use-singularity \\
--singularity-args "$SINGULARITY_BINDS" \\
--printshellcmds \\
--latency-wait 120 \\
--configfile ${WORKDIR}/config.yaml \\
--cluster-config ${WORKRESOURCESDIR}/cluster.json \\
EOF
if [ "$HOST" == "BIOWULF" ]; then
cat >> ${WORKDIR}/submit_script.sbatch << EOF
--cluster "sbatch --gres "lscratch:256" --cpus-per-task {cluster.threads} -p {cluster.partition} -t {cluster.time} --mem {cluster.mem} --job-name {cluster.name} --output {cluster.output} --error {cluster.error}" \\
EOF
elif [ "$HOST" == "FRCE" ];then
cat >> ${WORKDIR}/submit_script.sbatch << EOF
--cluster "sbatch --cpus-per-task {cluster.threads} -p {cluster.partition} -t {cluster.time} --mem {cluster.mem} --job-name {cluster.name} --output {cluster.output} --error {cluster.error}" \\
EOF
fi
cat >> ${WORKDIR}/submit_script.sbatch << EOF
-j 500 \\
--rerun-incomplete \\
--keep-going \\
--stats ${WORKDIR}/snakemake.stats \\
2>&1|tee ${WORKDIR}/snakemake.log
if [ "\$?" -eq "0" ];then
  snakemake -s $SNAKEFILE \\
  --directory $WORKDIR \\
  --report ${WORKDIR}/runslurm_snakemake_report.html \\
  --configfile ${WORKDIR}/config.yaml 
fi
bash <(curl https://raw.githubusercontent.com/CCBR/Tools/master/Biowulf/gather_cluster_stats.sh 2>/dev/null) ${WORKDIR}/snakemake.log > ${WORKDIR}/snakemake.log.HPC_summary.txt
EOF
  sbatch ${WORKDIR}/submit_script.sbatch
  elif [ "$1" == "--dry-run" ];then
  if [ -f ${WORKDIR}/dryrun.log ];then
    modtime=$(_get_file_modtime ${WORKDIR}/dryrun.log)
    mv ${WORKDIR}/dryrun.log ${WORKDIR}/logs/dryrun.log.${modtime}
  fi
snakemake $1 -s $SNAKEFILE \
--directory $WORKDIR \
--use-envmodules \
--printshellcmds \
--latency-wait 120 \
--configfile ${WORKDIR}/config.yaml \
--cluster-config ${WORKRESOURCESDIR}/cluster.json \
--cluster "sbatch --cpus-per-task {cluster.threads} -p {cluster.partition} -t {cluster.time} --mem {cluster.mem} --job-name {cluster.name} --output {cluster.output} --error {cluster.error}" \
-j 500 \
--rerun-incomplete \
--keep-going \
--stats ${WORKDIR}/snakemake.stats > ${WORKDIR}/dryrun.log 2>&1
cat ${WORKDIR}/dryrun.log 
  else # for unlock
snakemake $1 -s $SNAKEFILE \
--directory $WORKDIR \
--use-envmodules \
--printshellcmds \
--latency-wait 120 \
--configfile ${WORKDIR}/config.yaml \
--cluster-config ${WORKRESOURCESDIR}/cluster.json \
--cluster "sbatch --cpus-per-task {cluster.threads} -p {cluster.partition} -t {cluster.time} --mem {cluster.mem} --job-name {cluster.name} --output {cluster.output} --error {cluster.error}" \
-j 500 \
--rerun-incomplete \
--keep-going \
--stats ${WORKDIR}/snakemake.stats
  fi
}
function reset() {
  echo -ne "Working Dir: \t\t $WORKDIR\n"
  if [ ! -d $WORKDIR ];then err "Folder $WORKDIR does not exist!";fi
  echo "Deleting $WORKDIR"
  rm -rf $WORKDIR
  echo "Re-Initializing $WORKDIR"
  init
}
function main(){
  if [ $# -eq 0 ]; then usage && exit 1; fi
  for i in "$@"; do
  case $i in
      -m=*|--runmode=*)
        RUNMODE="${i#*=}"
      ;;
      -w=*|--workdir=*)
        WORKDIR="${i#*=}"
        WORKRESOURCESDIR="${WORKDIR}/resources"
        WORKSCRIPTSDIR="${WORKDIR}/scripts"
      ;;
      *)
        err "Unknown argument!"    # unknown option
      ;;
  esac
  done
  WORKDIR=$(readlink -f "$WORKDIR")
  case $RUNMODE in
    init) init && exit 0;;
    dryrun) dryrun && exit 0;;
    unlock) unlock && exit 0;;
    run) runslurm && exit 0;;
    runlocal) runlocal && exit 0;;
    reset) reset && exit 0;;
    dry) dryrun && exit 0;;                      # hidden option
    local) runlocal && exit 0;;                  # hidden option
    reconfig) reconfig && exit 0;;               # hidden option for debugging
    printbinds) printbinds && exit 0;;           # hidden option
    *) err "Unknown RUNMODE \"$RUNMODE\"";;
  esac
}
main "$@"

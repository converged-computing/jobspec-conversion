#!/bin/bash
#FLUX: --job-name=microbedb-update
#FLUX: -t=900
#FLUX: --priority=16

export SRCDIR='$SRCDIR'
export WORKDIR='${WORKDIR:-$(mktemp -d ${HOME}/scratch/microbedb_update$(date +'%Y_%m_%d').XXXXXXXXX)}'
export QUERY='$QUERY'
export OUTDIR='$OUTDIR'
export DBPATH='$DBPATH'
export REPOPATH='$REPOPATH'
export STEP='$STEP'
export KEYPATH='$KEYPATH'
export STRATUM0='$STRATUM0'
export PATH='$PATH'
export NOCOMMIT='$NOCOMMIT'
export SKIP_RSYNC='$SKIP_RSYNC'
export KEEP_OUTDIR='$KEEP_OUTDIR'
export CLEAN='$CLEAN'
export LOCAL_FETCH='$LOCAL_FETCH'
export NCBI_API_KEY='${NCBI_API_KEY:-$(gopass show 'brinkman/websites/ncbi.nlm.nih.gov/brinkmanlab' api_key)}'
export COUNT='$COUNT'
export TASKCOUNT='$TASKCOUNT'

set -e -o pipefail            # Halt on error
export SRCDIR="$(dirname $(realpath "$0"))"
export WORKDIR=${WORKDIR:-$(mktemp -d ${HOME}/scratch/microbedb_update$(date +'%Y_%m_%d').XXXXXXXXX)}
cd "$WORKDIR"
echo "WORKDIR: $WORKDIR"
export QUERY="${QUERY:-(\"bacteria\"[Organism] OR \"archaea\"[Organism]) AND (\"complete genome\"[Assembly Level] OR \"reference genome\"[RefSeq Category])}"
export OUTDIR="${OUTDIR:-${WORKDIR}/microbedb}"
export DBPATH="${DBPATH:-${OUTDIR}/microbedb.sqlite}"
export REPOPATH="${REPOPATH:-/cvmfs/microbedb.brinkmanlab.ca}"
export STEP=${STEP:-200} # Number of assemblies to process per job
export KEYPATH="${KEYPATH:-${HOME}/.ssh/cvmfs.pem}"
export STRATUM0="${STRATUM0:-centos@stratum-0.brinkmanlab.ca}"
export PATH="${PATH}:${EDIRECT:-$(realpath "$SRCDIR"/edirect)}"
module load python/3.9.6 sqlite/3.36
source "$SRCDIR"/venv/bin/activate
cat <<ENV >job.env
cd "$WORKDIR"
export QUERY='$QUERY'
export OUTDIR="$OUTDIR"
export DBPATH="$DBPATH"
export REPOPATH="$REPOPATH"
export SRCDIR="$SRCDIR"
export STEP=$STEP
export KEYPATH="$KEYPATH"
export STRATUM0="$STRATUM0"
export PATH="$PATH"
export NOCOMMIT="$NOCOMMIT"
export SKIP_RSYNC="$SKIP_RSYNC"
export KEEP_OUTDIR="$KEEP_OUTDIR"
export CLEAN="$CLEAN"
export LOCAL_FETCH="$LOCAL_FETCH"
module load python/3.9.6 sqlite/3.36
source "$SRCDIR"/venv/bin/activate
ENV
if [[ -f "$SRCDIR"/NCBI_API_KEY ]]; then
  NCBI_API_KEY="$(cat "$SRCDIR"/NCBI_API_KEY)"
fi
export NCBI_API_KEY=${NCBI_API_KEY:-$(gopass show 'brinkman/websites/ncbi.nlm.nih.gov/brinkmanlab' api_key)}
echo "Checking dependencies.."
echo -n "biopython.convert " && biopython.convert -v
xq --version
gawk --version | head -1
gawk '@load "filefuncs";'
jq --version && echo '""' | jq 'capture(".")'
rsync --version | head -1
parallel --version | head -1
echo -n "sqlite3 " && sqlite3 --version
find --version  | head -1 && find --help | grep '-empty'
ssh -V
echo "Preparing ${OUTDIR}.."
if [[ -z $SKIP_RSYNC ]]; then
  rm -rf "${OUTDIR}"
  mkdir -p "${OUTDIR}"
else
  rm -f ${OUTDIR}/*.*
fi
cp "${SRCDIR}/README.md" "${OUTDIR}"
cp "${SRCDIR}/subclassOf.sh" "${OUTDIR}"
cp "${SRCDIR}/resume.sh" "${WORKDIR}"
echo "Generating query.."
esearch -db 'assembly' -query "${QUERY}" >query.xml
export COUNT=${COUNT:-$(xq -r '.ENTREZ_DIRECT.Count' query.xml)}
if [[ -z "$COUNT" || "$COUNT" -eq 0 ]]; then
  echo "No results returned from query"
  exit 1
fi
TASKCOUNT=$((COUNT / STEP))
if [[ $COUNT -gt $STEP && $((COUNT % STEP)) -ne 0 ]]; then let ++TASKCOUNT; fi
cat <<ENV >>job.env
export TASKCOUNT=$TASKCOUNT
export COUNT=$COUNT
ENV
echo "Preparing database.."
rm -f "${DBPATH}"
sqlite3 -bail "${DBPATH}" <"${SRCDIR}/schema.sql"
if [[ -z $SKIP_TAXONOMY ]]; then
  # Load taxonomy data
  echo "Downloading taxonomy data.."
  rsync --progress --update rsync://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz .
  rm -rf taxdump
  mkdir taxdump
  tar -xvf taxdump.tar.gz -C taxdump
  echo "Converting taxonomy data to CSV.."
  # Convert to CSV as SQLITE doesn't support multi-char delimiters
  sed -i 's/"/""/g' taxdump/*.dmp
  sed -i 's/^/"/g' taxdump/*.dmp
  sed -i 's/\t|$/"/g' taxdump/*.dmp
  sed -i 's/\t|\t/","/g' taxdump/*.dmp
  echo "Loading taxonomy data.."
  sqlite3 -bail "${DBPATH}" <<EOF
PRAGMA foreign_keys = ON;
.mode csv
.import taxdump/names.dmp taxonomy_names
.import taxdump/division.dmp taxonomy_divisions
.import taxdump/gencode.dmp taxonomy_gencode
.import taxdump/nodes.dmp taxonomy_nodes
.import taxdump/merged.dmp taxonomy_merged
.import taxdump/delnodes.dmp taxonomy_deleted
.import taxdump/citations.dmp taxonomy_citations
EOF
fi
echo "Setting folder permissions.."
chmod -R ugo+rX "$WORKDIR"
echo -n "Downloading records.."
for ((i = 0; i < $TASKCOUNT; i++)); do
  START=$((i * STEP))
  STOP=$((START + STEP - 1))
  if [[ $STOP -ge $COUNT ]]; then
    STOP=$((COUNT - 1))
  fi
  efetch -mode json -format docsum -start "$START" -stop "$STOP" <query.xml >"${i}_raw.json"
  # Verify Entrez API version
  VERSION="$(tr '\n' ' ' < "${i}_raw.json" | jq -r '.header.version')"
  if [ "$VERSION" != '0.3' ]; then
    echo "Unexpected Entrez API version '$VERSION'. Update this script to accept new Entrez response schema."
    exit 1
  fi
  ERROR="$(tr '\n' ' ' < "${i}_raw.json" | jq -r '.error')"
  if [[ $ERROR != 'null' ]]; then
    echo "Failed to fetch subquery from NCBI:"
    echo "$ERROR"
    exit 1
  fi
  # Remove non-refseq records and .uids list
  jq '.result | del(.uids) | with_entries(select(.value.rsuid != ""))' "${i}_raw.json" >"${i}.json"
  echo -n "."
done
echo
if [[ -n $LOCAL || -n $LOCAL_FETCH ]]; then
  # Run fetch locally rather than sbatch
  echo "Running fetch.sh locally for $COUNT records"
  if [[ -z $CLEAN && ! -d $REPOPATH ]]; then
    # mount repo in userspace if doesn't exist
    export REPOPATH="${WORKDIR}/cvmfs/"
    mkdir -p "$REPOPATH"
    cvmfs2 -o config="$SRCDIR/cvmfs.cc.conf" "$REPONAME" "$REPOPATH"
  fi
  for ((i = 0; i < $TASKCOUNT; i++)); do
    SLURM_TMPDIR="$(mktemp -d microbedb_$i.XXXXXXXXXX)"
    SLURM_ARRAY_TASK_ID=$i SLURM_TMPDIR="$SLURM_TMPDIR" "${SRCDIR}/fetch.sh"
    rm -rf "$SLURM_TMPDIR"
  done
  if [[ "$REPOPATH" = "${WORKDIR}/cvmfs/" ]]; then
    fusermount -u "$REPOPATH"
  fi
fi
if [[ -n $LOCAL ]]; then
  # Run scripts locally rather than sbatch
  echo "Running process.sh locally for $COUNT records"
  for ((i = 0; i < $TASKCOUNT; i++)); do
    SLURM_TMPDIR="$(mktemp -d microbedb_$i.XXXXXXXXXX)"
    SLURM_ARRAY_TASK_ID=$i SLURM_TMPDIR="$SLURM_TMPDIR" "${SRCDIR}/process.sh"
    rm -rf "$SLURM_TMPDIR"
  done
  echo "Running finalize.sh locally.."
  SLURM_TMPDIR="$(mktemp -d microbedb_final.XXXXXXXXXX)"
  SLURM_TMPDIR="$SLURM_TMPDIR" "$SRCDIR"/finalize.sh
  rm -rf "$SLURM_TMPDIR"
else
  # Batch submit process.sh
  # Handle https://support.computecanada.ca/otrs/customer.pl?Action=CustomerTicketZoom;TicketID=135515
  echo "Calculating max array size.."
  MAXARRAYSIZE=$(scontrol show config | grep MaxArraySize | grep -oP '\d+')
  if [[ $MAXARRAYSIZE -lt $TASKCOUNT ]]; then
    echo "SLURM MaxArraySize is less than the number of records to process: $TASKCOUNT > $MAXARRAYSIZE"
    echo "This is possibly due to a misconfiguration of max_array_tasks and MaxArraySize in the SLURM config."
    exit 1
  fi
  echo "Submitting $COUNT records with process.sh to sbatch"
  job=$(sbatch --array=0-$((TASKCOUNT - 1)) "${SRCDIR}/process.sh")
  if [[ $job =~ ([[:digit:]]+) ]]; then # sbatch may return human readable string including job id, or only job id
    echo "Scheduling finalize.sh after job ${BASH_REMATCH[1]} completes"
    sbatch --dependency="afterok:${BASH_REMATCH[1]}" "${SRCDIR}/finalize.sh"
    echo "Run 'squeue -rj ${BASH_REMATCH[1]}' to monitor progress"
  else
    echo "finalize.sh failed to schedule, sbatch failed to return job id for fetch.sh"
    exit 1
  fi
fi
echo "WORKDIR: $WORKDIR"
echo "Done."

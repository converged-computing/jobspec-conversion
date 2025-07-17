#!/bin/bash
#FLUX: --job-name=gmd_paper_dyn
#FLUX: --exclusive
#FLUX: -t=172800
#FLUX: --urgency=16

export OGGM_DOWNLOAD_CACHE='/home/data/download'
export OGGM_DOWNLOAD_CACHE_RO='1'
export OGGM_EXTRACT_DIR='/work/$SLURM_JOB_USER/$SLURM_JOB_ID/oggm_tmp'

set -e
RGI_REG=`printf "%02d" $SLURM_ARRAY_TASK_ID`
export RGI_REG
WORKDIR="/work/$SLURM_JOB_USER/$SLURM_JOB_ID/rgi_reg_$RGI_REG"
mkdir -p "$WORKDIR"
echo "RGI Region: $RGI_REG"
echo "Workdir for this run: $WORKDIR"
export WORKDIR
export OGGM_DOWNLOAD_CACHE=/home/data/download
export OGGM_DOWNLOAD_CACHE_RO=1
export OGGM_EXTRACT_DIR="/work/$SLURM_JOB_USER/$SLURM_JOB_ID/oggm_tmp"
srun -n 1 -c "${SLURM_JOB_CPUS_PER_NODE}" singularity exec docker://oggm/oggm:20181123 bash -s <<EOF
  set -e
  # Setup a fake home dir inside of our workdir, so we don't clutter the actual shared homedir with potentially incompatible stuff.
  export HOME="$WORKDIR/fake_home"
  mkdir "\$HOME"
  # Create a venv that _does_ use system-site-packages, since everything is already installed on the container.
  # We cannot work on the container itself, as the base system is immutable.
  python3 -m venv --system-site-packages "$WORKDIR/oggm_env"
  source "$WORKDIR/oggm_env/bin/activate"
  # Make sure latest pip is installed
  pip install --upgrade pip setuptools
  # Install a fixed OGGM version
  pip install --upgrade "git+https://github.com/OGGM/oggm.git@a74695fcaba0fc50580109bb578ff64df51b3f62"
  # pip install "git+https://github.com/fmaussion/oggm.git@dev"
  # Finally, the run
  python3 ./run.py
EOF
echo "Start copying..."
OUTDIR=/home/users/fmaussion/gmd_run_output/
mkdir -p "${OUTDIR}/rgi_reg_$RGI_REG/"
cp "${WORKDIR}/"run_output*.nc "${OUTDIR}/rgi_reg_$RGI_REG/"
cp "${WORKDIR}/"task_log*.csv "${OUTDIR}/rgi_reg_$RGI_REG/"
echo "SLURM DONE"

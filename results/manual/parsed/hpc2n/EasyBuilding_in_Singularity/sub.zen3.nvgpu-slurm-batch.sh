#!/bin/bash
#SBATCH --job-name=EB-install
#SBATCH --account=easybuild
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --time=06:00:00
#SBATCH --partition=amd_gpu
#SBATCH --constraint=zen3&2xA100

export SBATCH_CONSTRAINT='zen3&2xA100'
export SBATCH_ACCOUNT='$SLURM_JOB_ACCOUNT'
export SBATCH_PARTITION='$SLURM_JOB_PARTITION'

ml purge > /dev/null 2>&1
ml eb_builder/${EB_BRANCH:-default}
if [ "x$EB_BRANCH" = "xdevelop" ]; then
    if [ -z "$EBUSER" ]; then
        echo "EBUSER MUST be set when using eb_builder/develop"
        exit 1
    fi
fi
export SBATCH_CONSTRAINT="zen3&2xA100"
export SBATCH_ACCOUNT=$SLURM_JOB_ACCOUNT
export SBATCH_PARTITION=$SLURM_JOB_PARTITION
p=`pwd`
tl="--tmp-logdir=$p/tmplogs/$SLURM_JOB_ID"
if [ $(expr match "$EB_INSTALL_PARAMS" '^.*--job') -ne 0 ]; then
    if [ $(expr match "$EB_INSTALL_PKG" '^.*--from-pr') -ne 0 ]; then
        td="--disable-cleanup-tmpdir --tmpdir=$p/tmpdir/$SLURM_JOB_ID"
        export EASYBUILD_TMPDIR=$p/tmpdir/$SLURM_JOB_ID
    fi
fi
if [ -z "$EB_CMD" ]; then
    EB_CMD=eb
fi
if [ -z "$EB_INSTALL_PKG" ]; then
    echo Forcing spider cache update
    eb
else
    echo $EB_CMD $EB_INSTALL_PKG $EB_INSTALL_PARAMS $bp $tl $td
    $EB_CMD $EB_INSTALL_PKG $EB_INSTALL_PARAMS $bp $tl $td
fi

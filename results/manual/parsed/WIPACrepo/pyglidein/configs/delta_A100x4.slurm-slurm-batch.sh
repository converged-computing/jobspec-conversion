#!/bin/bash
#SBATCH --job-name=glidein
#SBATCH --account=bbfw-delta-gpu
#SBATCH --output=/u/riedel1/logs/%j.out
#SBATCH --error=/u/riedel1/logs/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --mem=56G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpuA100x4
#SBATCH --constraint=ntasks-per-node=1

echo `date`
echo $HOSTNAME
MEMORY=56000 # 11600
WALLTIME=86400
CPUS=14
DISK=81920000000
if [ "$CUDA_VISIBLE_DEVICES" -eq "$CUDA_VISIBLE_DEVICES" ] 2>/dev/null ; then
  GPUS="CUDA${CUDA_VISIBLE_DEVICES}"
elif [ "x$CUDA_VISIBLE_DEVICES" = "x" ] ; then
  GPUS=1
else
  GPUS=$CUDA_VISIBLE_DEVICES
fi
SITE="Delta"
GLIDEIN_LOC=/u/riedel1/pyglidein/pyglidein
LOCAL_DIR=/tmp/
CVMFSEXEC_DIR=/u/riedel1/cvmfsexec/
mkdir -p ${LOCAL_DIR}
cd $LOCAL_DIR
cp -a /u/riedel1/cvmfsexec . 
ls ${LOCAL_DIR}/cvmfsexec
echo "---"
mkdir glidein
cd glidein
echo $PWD
cp $GLIDEIN_LOC/glidein_start.sh .
cp $GLIDEIN_LOC/os_arch.sh .
cp $GLIDEIN_LOC/log_shipper.sh .
cp $GLIDEIN_LOC/startd_cron_scripts/clsim_gpu_test.py .
cp $GLIDEIN_LOC/startd_cron_scripts/cvmfs_test.py .
cp $GLIDEIN_LOC/startd_cron_scripts/gridftp_test.py .
cp $GLIDEIN_LOC/startd_cron_scripts/post_cvmfs.sh .
cp $GLIDEIN_LOC/startd_cron_scripts/pre_cvmfs.sh .
/tmp/cvmfsexec/cvmfsexec oasis.opensciencegrid.org singularity.opensciencegrid.org icecube.opensciencegrid.org -- /cvmfs/oasis.opensciencegrid.org/mis/singularity/bin/singularity exec -B /etc/OpenCL --nv --bind /tmp/cvmfsexec/dist/cvmfs:/cvmfs --cleanenv --env DISK=$DISK,CPUS=$CPUS,GPUS=$GPUS,MEMORY=$MEMORY,WALLTIME=$WALLTIME,SITE=$SITE,ResourceName=$SITE,DISABLE_STARTD_CHECKS=$DISABLE_STARTD_CHECKS docker://opensciencegrid/osgvo-el7-cuda10 ./glidein_start.sh

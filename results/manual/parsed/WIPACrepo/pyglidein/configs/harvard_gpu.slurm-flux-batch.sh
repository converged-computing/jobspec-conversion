#!/bin/bash
#FLUX: --job-name=astute-lemon-5098
#FLUX: -n=2
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

echo `date`
echo $HOSTNAME
echo "-----------------Removing FUSE mounts------------------"
MEMORY=11600
WALLTIME=86400
CPUS=2
DISK=81920000000
if [ "$CUDA_VISIBLE_DEVICES" -eq "$CUDA_VISIBLE_DEVICES" ] 2>/dev/null ; then
  GPUS="CUDA${CUDA_VISIBLE_DEVICES}"
elif [ "x$CUDA_VISIBLE_DEVICES" = "x" ] ; then
  GPUS=1
else
  GPUS=$CUDA_VISIBLE_DEVICES
fi
GPU2=$(nvidia-smi --query-gpu=index --format=csv,noheader);
echo "GPU2=$GPU2"
echo "GPU=$GPUS"
SITE="Harvard"
GLIDEIN_LOC=/n/home00/briedel/pyglidein/pyglidein
LOCAL_DIR=/n/holyscratch01/arguelles_delgado_lab/Lab/IceCube/prod/$SLURM_JOB_ID/
CVMFSEXEC_DIR=/n/home00/briedel/cvmfsexec/
mkdir -p $LOCAL_DIR
ls ${LOCAL_DIR}/cvmfsexec
echo "---"
echo "-------Unmount repo------" | tee /dev/stderr 
echo "-------Mount repo------" | tee /dev/stderr
cd $LOCAL_DIR
echo $PWD
cp $GLIDEIN_LOC/glidein_start.sh glidein_start.sh
cp $GLIDEIN_LOC/os_arch.sh os_arch.sh
cp $GLIDEIN_LOC/log_shipper.sh log_shipper.sh
cp $GLIDEIN_LOC/startd_cron_scripts/clsim_gpu_test.py clsim_gpu_test.py
cp $GLIDEIN_LOC/startd_cron_scripts/cvmfs_test.py cvmfs_test.py
cp $GLIDEIN_LOC/startd_cron_scripts/gridftp_test.py gridftp_test.py
cp $GLIDEIN_LOC/startd_cron_scripts/post_cvmfs.sh post_cvmfs.sh
cp $GLIDEIN_LOC/startd_cron_scripts/pre_cvmfs.sh pre_cvmfs.sh
ls $PWD
echo '-------------------------------'
echo $SITE
echo $GPUS
exec env -i CPUS=$CPUS GPUS=$GPUS MEMORY=$MEMORY DISK=$DISK WALLTIME=$WALLTIME DISABLE_STARTD_CHECKS=$DISABLE_STARTD_CHECKS SITE=$SITE ResourceName=$SITE ./glidein_start.sh

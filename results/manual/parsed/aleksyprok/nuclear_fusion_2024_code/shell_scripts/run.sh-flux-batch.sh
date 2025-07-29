#!/bin/bash
#FLUX: --job-name=gpujob
#FLUX: -n=248
#FLUX: --exclusive
#FLUX: --queue=$partition
#FLUX: --urgency=16

export HDF5_DIR='/usr/local/software/spack/spack-rhel8-20210927/opt/spack/linux-centos8-zen2/nvhpc-22.3/hdf5-1.10.7-strpuv55e7ggr5ilkjrvs2zt3jdztwpv'
export OMP_NUM_THREADS='$ngpu'
export LIBRARY_PATH='$LIBRARY_PATH:"$HDF5_DIR/lib'
export CFLAGS='-I$HDF5_DIR/include'
export FFLAGS='-I$HDF5_DIR/include'
export LDFLAGS='-L$HDF5_DIR/lib'
export OMP_STACKSIZE='102400'
export CUDA_CACHE_DISABLE='1'

device="csd3"
tokamak="STEP"
run_name="FEC_2024"
if [[ $device == "csd3" ]]; then
account="ukaea-ap001-GPU"
partition="ampere"
time="36:00:00"
ngpu=4
elif [[ $device == "leonardo" ]]; then
account="FUAL7_UKAEA_ML"
partition="boost_fua_prod"
time="24:00:00"
ngpu=4
elif [[ $device == "sdcc" ]]; then
account="default"
partition="gpu_p100_titan"
time="99-00:00:00"
ngpu=1
else
echo "Invalid device."
exit 1
fi
cat > job.sbatch << EOF
device=$device
if [[ \$device == "csd3" ]]; then
. /etc/profile.d/modules.sh
module purge
module load rhel8/default-amp
module load nvhpc/22.3/gcc-9.4.0-ywtqynx
module load hdf5/1.10.7/openmpi-4.1.1/nvhpc-22.3-strpuv5
elif [[ \$device == "leonardo" ]]; then
module purge
module load nvhpc/23.1
elif [[ \$device == "sdcc" ]]; then
module purge
module load IMAS
fi
workdir="\$SLURM_SUBMIT_DIR"
cd \$workdir
ulimit -s 2000000
echo "OMP_NUM_THREADS="\$OMP_NUM_THREADS
echo $HOSTNAME
rm -vf $HOME"/locust."$tokamak"/CacheFiles/"\$HOSTNAME"/"*
$HOME"/locust/locust_"$run_name"_"\$SLURM_ARRAY_TASK_ID
EOF
sbatch job.sbatch

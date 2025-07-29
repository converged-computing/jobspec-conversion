#!/bin/bash
#FLUX: --job-name=SnBeastTest
#FLUX: --queue=savio3_gpu
#FLUX: -t=4799
#FLUX: --urgency=16

export ImgDir='/clusterfs/vector/home/groups/software/sl-7.x86_64/modules/beast/2.6.4/'

LOGDIR=/global/scratch/users/tin/JUNK/
MAQ=$(hostname)
TAG=$(hostname).$(date +%m%d.%H%M)
OUTFILE=slurm-job-gpu-beast.$TAG.out.rst
echo ----hostname-----------------------------------
echo -n "hostname: " 
hostname 
echo ----date-----------------------------------
date
echo ----os-release----------------------------------
cat /etc/os-release
echo ----lscpu-----------------------------------
lscpu
echo ----nvidia-smi-----------------------------------
nvidia-smi
echo "---module list before purge ------------------------------------"
module list    2>&1
module purge   2>&1
module load ml/tensorflow/1.12.0-py36 2>&1 
echo "---module list after purge ------------------------------------"
module list    2>&1
echo "==== ================= ======================================================="
echo "==== beast/gpu next == =======================================================" 
echo "==== ================= ======================================================="
export ImgDir=/clusterfs/vector/home/groups/software/sl-7.x86_64/modules/beast/2.6.4/
echo "checking beagle with gpu (currently need CUDA 11.4)"
singularity exec --nv $ImgDir/beast2.6.4-beagle.sif /usr/bin/java -Dlauncher.wait.for.exit=true -Xms256m -Xmx8g -Duser.language=en -cp /opt/gitrepo/beast/lib/launcher.jar beast.app.beastapp.BeastLauncher -beagle_info
echo "running beast2 with beagle/gpu"
cd /global/scratch/users/tin/gitrepo/beast2/examples
git checkout 2.6.6 
singularity exec --nv $ImgDir/beast2.6.4-beagle.sif /usr/bin/java -Dlauncher.wait.for.exit=true -Xms256m -Xmx8g -Duser.language=en -cp /opt/gitrepo/beast/lib/launcher.jar beast.app.beastapp.BeastLauncher -beagle_GPU testHKY.xml

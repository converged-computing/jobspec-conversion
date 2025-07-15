#!/bin/bash
#FLUX: --job-name=wobbly-avocado-3170
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --priority=16

echo START BY $USER AT `date`
nvidia-smi
module purge
module load gcc cuda cudnn python/2.7 mvapich2
source /home/$USER/venvs/atloc/bin/activate
TEMP=$TMPDIR
TEMP+="/AtLoc-master"
mkdir $TEMP
cp -r ~/cs433-atloc4topo/AtLoc-master/* $TEMP
mkdir -p $TEMP/data/Topo
for archive in $(find /work/topo/VNAV/Synthetic_Data/comballaz/comballaz_archive/comballaz-v1-archive)
do
   mkdir -p $TEMP/data/Topo/"${archive:41:-4}"
   unzip $archive -d $TEMP/data/Topo/${archive:41:-4}
done
mkdir -p $TEMP/data/Topo/loop
cp -r $TEMP/data/Topo/comballaz_archive/comballaz-v1-archive/* $TEMP/data/Topo/loop
rm -r $TEMP/data/Topo/com*
for folder in $(find $TEMP/data/Topo/loop -maxdepth 1 -name *comballaz*)
do
   cp -r $folder/home/qiyan/Downloads/* "$folder" 2>/dev/null || :
   rm -r -f $folder/home
done
rm -rf $TEMP/data/Topo/loop/Readm
rm -rf $TEMP/data/Topo/loop/lhs-point-whole
rm -rf $TEMP/data/Topo/loop/comballaz-v1
srun python $TEMP/run.py --dataset Topo --model AtLoc --data_dir $TEMP/data --logdir /home/$USER/cs433-atloc4topo/AtLoc-master/logs
wait
srun python $TEMP/train.py --dataset Topo --model AtLoc --gpus 0 --data_dir $TEMP/data --logdir /home/$USER/cs433-atloc4topo/AtLoc-master/logs
wait
echo END OF $SLURM_JOB_ID AT `date`

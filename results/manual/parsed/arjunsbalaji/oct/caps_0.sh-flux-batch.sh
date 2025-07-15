#!/bin/bash
#FLUX: --job-name=boopy-animal-2110
#FLUX: --queue=gpuq
#FLUX: -t=7200
#FLUX: --priority=16

export myRep='$MYGROUP/singularity/oct_ca '
export containerImage='$myRep/oct_ca_latest-fastai-skl-ski-mlflow-d2-opencv-coco.sif'
export projectDir='$MYGROUP/projects'
export X_MEMTYPE_CACHE='n'

module load singularity
export myRep=$MYGROUP/singularity/oct_ca 
export containerImage=$myRep/oct_ca_latest-fastai-skl-ski-mlflow-d2-opencv-coco.sif
export projectDir=$MYGROUP/projects
cd /group/pawsey0271/abalaji/projects/oct_ca_seg/oct/  
ulimit -s unlimited
export X_MEMTYPE_CACHE=n
srun --export=all -n 1 singularity exec -B $projectDir:/workspace --nv $containerImage python3 pawsey/caps_0.py #pawsey/train_caps.py 10 4 

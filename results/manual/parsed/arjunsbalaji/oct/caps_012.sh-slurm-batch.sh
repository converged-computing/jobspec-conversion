#!/bin/bash
#SBATCH --account=pawsey0271
#SBATCH --output=DEEEPCAP%j.out
#SBATCH --mail-user=21713337@student.uwa.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00
#SBATCH --constraint=p100

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
srun --export=all -n 1 singularity exec -B $projectDir:/workspace --nv $containerImage python3 pawsey/caps_012.py #pawsey/train_caps.py 10 4 

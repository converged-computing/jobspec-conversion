#!/bin/bash
#SBATCH --job-name=visdrone_train
#SBATCH --account=def-mpederso
#SBATCH --output=vis_train-%J.out
#SBATCH --mail-user=akhilpm135@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=24G
#SBATCH --time=11:50:00

export COMET_DISABLE_AUTO_LOGGING='1'

module load gcc python cuda/11.4 opencv/4.5.5
module load httpproxy
source ~/envs/detectron2/bin/activate
export COMET_DISABLE_AUTO_LOGGING=1
mkdir  $SLURM_TMPDIR/VisDrone
mkdir  $SLURM_TMPDIR/VisDrone/train
unzip -q ~/projects/def-mpederso/akhil135/data_Aerial/VisDrone/VisDrone2019-DET-train.zip -d $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/VisDrone2019-DET-train/images/ $SLURM_TMPDIR/VisDrone/train
cp ~/projects/def-mpederso/akhil135/data_Aerial/VisDrone/annotations_VisDrone_train.json $SLURM_TMPDIR/VisDrone/
mkdir  $SLURM_TMPDIR/VisDrone/val
unzip -q ~/projects/def-mpederso/akhil135/data_Aerial/VisDrone/VisDrone2019-DET-val.zip -d $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/VisDrone2019-DET-val/images/ $SLURM_TMPDIR/VisDrone/val
cp ~/projects/def-mpederso/akhil135/data_Aerial/VisDrone/annotations_VisDrone_val.json $SLURM_TMPDIR/VisDrone/
mkdir $SLURM_TMPDIR/VisDrone/test
unzip -q ~/projects/def-mpederso/akhil135/data_Aerial/VisDrone/VisDrone2019-DET-test.zip -d $SLURM_TMPDIR
cp -r $SLURM_TMPDIR/VisDrone2019-DET-test/images/ $SLURM_TMPDIR/VisDrone/test
cp ~/projects/def-mpederso/akhil135/data_Aerial/VisDrone/annotations_VisDrone_test.json $SLURM_TMPDIR/VisDrone/
python train_net.py --resume --num-gpus 1 --config-file configs/visdrone/Semi-Sup-RCNN-FPN-CROP.yaml OUTPUT_DIR ~/scratch/DroneSSOD/Temp

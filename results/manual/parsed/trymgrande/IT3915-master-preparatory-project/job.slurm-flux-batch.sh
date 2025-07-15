#!/bin/bash
#FLUX: --job-name=yolov7-training-testing-with-augmentation
#FLUX: --queue=GPUQ
#FLUX: -t=86400
#FLUX: --urgency=16

AUGMENTATION_NUMBER=$1
WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo " the name of the job is: $SLURM_JOB_NAME"
echo "The job ID is $SLURM_JOB_ID"
echo "The job was run on these nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
echo "We are using $SLURM_CPUS_ON_NODE cores per node"
echo "Total of $SLURM_NTASKS cores"
echo "Augmentation number: ${AUGMENTATION_NUMBER}"
module purge
module load intel/2020b
module list
module load Python/3.8.6-GCCcore-10.2.0
pip install -r requirements.txt
mkdir job-environment-$SLURM_JOB_ID-$AUGMENTATION_NUMBER
cd job-environment-$SLURM_JOB_ID-$AUGMENTATION_NUMBER
git clone https://github.com/WongKinYiu/yolov7
cd yolov7
cp ../../augmentation.py .
cp ../../augmentation_transformations.py .
cp ../../torch_test.py .
python torch_test.py
pip install -r requirements.txt
pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113
echo "running augmentation..."
python augmentation.py $AUGMENTATION_NUMBER
echo "running training..."
python train.py --batch-size 80 --epochs 100 --data Merged-sheep-dataset-3/data.yaml --weights 'yolov7-tiny.pt' --workers 1 --device 0 --img 640 640
echo "running detection..."
python detect.py --weights runs/train/exp/weights/best.pt --conf 0.50 --source Merged-sheep-dataset-3/test/images
cp runs/ ../../runs/run-$SLURM_JOB_ID-$AUGMENTATION_NUMBER -r
cd ../..
echo "Job done"

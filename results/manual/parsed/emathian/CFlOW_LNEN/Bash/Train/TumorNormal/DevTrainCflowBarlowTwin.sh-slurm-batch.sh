#!/bin/bash
#SBATCH --job-name=CFlowBT
#SBATCH --account=uli@v100
#SBATCH --output=CFlowBarlowTwinWresnet50_Dev.out
#SBATCH --error=CFlowBarlowTwinWresnet50_Dev.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gpu:1
#SBATCH --time=00:30:00
#SBATCH --partition=gpu_p2
#SBATCH --qos=qos_gpu-dev
#SBATCH --constraint=ntasks-per-node=1

export PYTHONUSERBASE='/gpfswork/rech/uli/ueu39kt/.local_base_timm'

module purge
export PYTHONUSERBASE=/gpfswork/rech/uli/ueu39kt/.local_base_timm
module load pytorch-gpu/py3/1.9.0
mkdir /gpfsscratch/rech/uli/ueu39kt/CFLOW/weights/DevCflowBarlowTwin
srun python /linkhome/rech/genkmw01/ueu39kt/cflow-ad/main_cflow.py --gpu 0 -inp 384 --dataset TCAC   --root-data-path /gpfsscratch/rech/uli/ueu39kt/Tiles_HE_all_samples_384_384_Vahadane_2 --weights-dir /gpfsscratch/rech/ohv/ueu39kt/CFLOW/weights/DevCflowBarlowTwin --list-file-train infer_tiles_2711.txt --list-file-test infer_tiles_2711.txt --meta-epochs 25 --sub-epochs 8 --parallel --lr 2e-4 --enc-arch wide_resnet50_barlowtwin_LNEN

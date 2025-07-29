#!/bin/bash
#SBATCH --job-name=hu-g
#SBATCH --account=share-ie-idi
#SBATCH --output=huout/GTSRB_output.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20000
#SBATCH --time=7-00:00:00
#SBATCH --partition=GPUQ,V100-IDI,EPICALL
#SBATCH --constraint=ntasks-per-node=1

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo " the name of the job is: $SLURM_JOB_NAME"
echo "Th job ID is $SLURM_JOB_ID"
echo "The job was run on these nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
echo "We are using $SLURM_CPUS_ON_NODE cores per node"
echo "We are using $SLURM_GPUS_ON_NODE GPUs per node"
echo "Total of $SLURM_NTASKS cores"
echo "CUDA_VISILE DEVICES: $CUDA_VISIBLE_DEVICES"
module purge
module load GCC/8.2.0-2.31.1
module load CUDA/10.1.105
module load OpenMPI/3.1.3
echo "loading python"
module load Python/3.7.2
module load TensorFlow/1.13.1-Python-3.7.2
if [ ! -d "gpu_env" ]; then
  python3 -m venv gpu_env
fi
source gpu_env/bin/activate
pip install -r cnn-cert-master/idun/requirements.txt
nvidia-smi
python cnn-cert-master/upper_bound_HSJA.py v10 GTSRB
uname -a

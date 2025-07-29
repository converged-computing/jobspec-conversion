#!/bin/bash
#SBATCH --job-name=road_detector
#SBATCH --account=ie-idi
#SBATCH --output=srun.out
#SBATCH --mail-user=joergen.rosager@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000
#SBATCH --time=05:00:00
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
echo "Total of $SLURM_NTASKS cores"
module purge
module load fosscuda/2020b
module load Anaconda3/2020.07
nvidia-smi
PYTHONPATH=/cluster/home/jorgro/road-detector python ./tools/train.py ./configs/road_detector.py --work-dir ./runs
uname -a

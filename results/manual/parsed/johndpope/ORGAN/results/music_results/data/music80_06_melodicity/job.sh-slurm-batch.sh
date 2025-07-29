#!/bin/bash
#SBATCH --job-name=music80_06_melodicity
#SBATCH --output=OGAN.out
#SBATCH --mail-user=gabrielguimaraes@college.harvard.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --mem-per-cpu=1024
#SBATCH --time=20-00:00:00
#SBATCH --constraint=cuda-7.5

export OMP_NUM_THREADS='8'

export OMP_NUM_THREADS=8
module load cuda/7.5-fasrc02 cudnn/7.0-fasrc02
module load gcc/4.9.3-fasrc01 tensorflow/1.0.0-fasrc04
source activate tfgpu
JOB_NAME=music80_06_melodicity
PY_SCRIPT='train_ogan.py'
CUR_DIR=$(pwd)
SCRATCH=/scratch
RESULTS=$(pwd)
touch $CUR_DIR/$JOB_NAME.start
echo "setuping up directories"
echo "  at ${SCRATCH}/${JOB_NAME}/${SLURM_JOB_ID}"
cd $SCRATCH
mkdir -p $JOB_NAME/$SLURM_JOB_ID
cd $JOB_NAME/$SLURM_JOB_ID
cp -Rv $CUR_DIR/* .
echo "running python"
python ${PY_SCRIPT}  2>&1 | tee ${CUR_DIR}/results.out
echo "copy results"
mv ${JOB_NAME}.out $RESULTS
cp -r * $RESULTS
touch $CUR_DIR/$JOB_NAME.done

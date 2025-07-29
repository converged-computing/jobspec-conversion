#!/bin/bash
#SBATCH --job-name=topics_nb
#SBATCH --output=output/jupyter_bert_out.txt
#SBATCH --error=output/jupyter_bert_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=48G
#SBATCH --time=04:00:00

export TOKENIZERS_PARALLELISM='true'

module purge
module add nvidia
module load anaconda3/latest
. $ANACONDA_HOME/etc/profile.d/conda.sh
echo "activating the cemtom env"
conda activate cemtom
conda info
pip list
PROJECT="/scratch/$USER/thesis/tms/atlas"
cd $PROJECT
export TOKENIZERS_PARALLELISM=true
module list
nvidia-smi
node=$(hostname -s)
jupyter-notebook --no-browser  --ip=${node}

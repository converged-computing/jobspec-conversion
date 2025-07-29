#!/bin/bash
#SBATCH --job-name=[CCIA] Install conda environment
#SBATCH --account=punim1124
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=51200
#SBATCH --time=01:00:00
#SBATCH --partition=cascade

export LD_LIBRARY_PATH='~/.conda/envs/r-cecelia-env/lib:$JAVA_HOME/jre/lib/amd64/server/'
export CONDA_ENVS_PATH='/data/gpfs/projects/punim1124/cecelia/envs/'

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
module load Java/8.372
module load Miniconda3/22.11.1-1
export LD_LIBRARY_PATH=~/.conda/envs/r-cecelia-env/lib:$JAVA_HOME/jre/lib/amd64/server/
export CONDA_ENVS_PATH=/data/gpfs/projects/punim1124/cecelia/envs/
. /apps/easybuild-2022/easybuild/software/Core/Miniconda3/22.11.1-1/bin/activate
conda activate 'r-cecelia-env'
R -e 'cecelia::cciaCondaCreate(envType = "image-nogui")'

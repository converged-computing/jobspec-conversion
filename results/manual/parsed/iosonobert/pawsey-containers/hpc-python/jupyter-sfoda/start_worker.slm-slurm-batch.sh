#!/bin/bash
#SBATCH --job-name=dask-worker
#SBATCH --account=pawsey0106
#SBATCH --output=dask-worker-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00

export SINGULARITY_BINDPATH='/group:/group,/scratch:/scratch,/run:/run,$HOME:$HOME '
export SINGULARITYENV_PREPEND_PATH='/srv/conda/envs/notebook/bin:/srv/conda/condabin:/srv/conda/bin'
export SINGULARITYENV_XDG_DATA_HOME='$MYSCRATCH/.local'

scheduler_file=$1
notebook_dir=$2
cd ${notebook_dir}
export SINGULARITY_BINDPATH=/group:/group,/scratch:/scratch,/run:/run,$HOME:$HOME 
export SINGULARITYENV_PREPEND_PATH=/srv/conda/envs/notebook/bin:/srv/conda/condabin:/srv/conda/bin
export SINGULARITYENV_XDG_DATA_HOME=$MYSCRATCH/.local
image="docker://mrayson/jupyter_sfoda:latest"
imagename=${image##*/}
imagename=${imagename/:/_}.sif
module load singularity/3.8.6
singularity pull $imagename $image
mempcpu=$SLURM_MEM_PER_CPU
memlim=$(echo $SLURM_CPUS_PER_TASK*$mempcpu*0.98 | bc)
echo Memory limit is $memlim
echo starting $SLURM_NTASKS workers with $SLURM_CPUS_PER_TASK CPUs each
srun --export=ALL -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK \
    singularity exec $imagename \
    dask-worker --scheduler-file $scheduler_file --nthreads $SLURM_CPUS_PER_TASK --memory-limit ${memlim}M 

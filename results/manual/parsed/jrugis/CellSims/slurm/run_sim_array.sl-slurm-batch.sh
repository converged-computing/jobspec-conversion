#!/bin/bash
#SBATCH --job-name=Cell_Sim
#SBATCH --account=nesi00119
#SBATCH --output=slurm.out
#SBATCH --error=slurm.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:29:00
#SBATCH --constraint=avx
#SBATCH --array=1-11

module load intel/2015a
module load Python/3.5.1-intel-2015a
module load CUDA/7.5.18
if [ ! -f _pan_array.in ]; then
    >&2 echo "Error: _pan_array.in file does not exist"
    exit 1
fi
line=$(head -n ${SLURM_ARRAY_TASK_ID} _pan_array.in | tail -1)
set $line
vExe=$2     # executable name
vModel=$3   # model name
vMesh=$4    # mesh name
vRoot=$5    # simulation root directory
echo "$HOSTNAME : $1"
cd "$1"
srun -o "$vExe.txt" "$vRoot/executables/$vExe"
mv cs.dat "$vModel.dat"
mv cs.msh "$vMesh.msh"
if [ -f c.bin ]; then
    # create reduced content output files
    srun --output=reduce.txt --ntasks=1 python "$vRoot/post/cs_reduce_min-max.py" "."
fi

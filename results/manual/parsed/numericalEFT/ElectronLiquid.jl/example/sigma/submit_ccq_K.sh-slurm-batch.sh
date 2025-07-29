#!/bin/bash
#SBATCH --job-name=cs
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --mail-user=chenkun0228@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --constraint=opa

echo "#########################################################" >  host.txt
echo "SLURM_JOB_NUM_NODES  =" $SLURM_JOB_NUM_NODES               >> host.txt
echo "SLURM_JOB_NODELIST   =" $SLURM_JOB_NODELIST                >> host.txt
echo "SLURM_NTASKS         =" $SLURM_NTASKS                      >> host.txt
echo "SLURM_TASKS_PER_NODE =" $SLURM_TASKS_PER_NODE              >> host.txt
echo "#########################################################" >> host.txt
module load slurm
module load julia
module load openmpi4
cd $SLURM_SUBMIT_DIR
/mnt/home/kunchen/.julia/bin/mpiexecjl julia /mnt/home/kunchen/project/EFT_UEG/sigma/sigmaK.jl >> output.dat

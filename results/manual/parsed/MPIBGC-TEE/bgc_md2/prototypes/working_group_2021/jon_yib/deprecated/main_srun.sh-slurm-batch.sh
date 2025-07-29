#!/bin/bash
#SBATCH --job-name=main_srun
#SBATCH --output=/scratch/jw2636/bgc_md2/prototypes/working_group_2021/jon_yib/dask.out.%J
#SBATCH --error=/scratch/jw2636/bgc_md2/prototypes/working_group_2021/jon_yib/dask.err.%J
#SBATCH --nodes=4
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10GB
#SBATCH --time=3-18:00:00
#SBATCH --constraint=amd
#SBATCH --chdir=/scratch/jw2636/bgc_md2/prototypes/working_group_2021/jon_yib

module purge
module load anaconda3/2021.05 #has to match the currently activated anaconda version in the shell
conda activate /scratch/jw2636/env_bgc
conda list
echo ""
echo "Conda location and version:"
which conda
conda --version
echo ""
echo "Subsequent python location and version:"
which python
python --version
echo ""
echo "Job information create by bash file:"
echo "Node number: $SLURM_NNODES"
echo "CPUs on node: $SLURM_CPUS_ON_NODE"
echo "Task number: $SLURM_NTASKS"
echo "Initial node: $SLURMD_NODENAME"
echo "Allocated nodes: $SLURM_NODELIST"
echo "OMP thread count: $OMP_NUM_THREADS"
echo ""
echo "Output from main.py:"
mpirun -n ${SLURM_NTASKS} python main.py

#!/bin/bash
#SBATCH --job-name=vmodes
#SBATCH --output=outjob_comp_vmodes.o%j
#SBATCH --error=outjob_comp_vmodes.e%j
#SBATCH --mail-user=noe.lahaye@inria.fr
#SBATCH --mail-type=END
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=1-00:00:00
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=7,BDW28

set -e
module purge
module load /opt/software/alfred/spack-dev/modules/tools/linux-rhel7-x86_64/miniconda3/4.7.12.1-gcc-4.8.5
eval "$(conda shell.bash hook)"
conda activate /scratch/cnt0024/ige2071/nlahaye/conda/conda38
nmpi=$SLURM_NTASKS #$(( $SLURM_NTASKS + 1 )) # this is (dangerous) cheating
echo "now doing it" `date` "JOB ID:" $SLURM_JOBID
ladate="20091227"
prog_name=compute_vmodes.py # proj_pres_ty-loop_local.py #
prog_work=${prog_name%".py"}.$SLURM_JOBID.py
cp $prog_name $prog_work
echo "running" $prog_work", using" $SLURM_NNODES" nodes, "$nmpi" tasks, "$SLURM_CPUS_PER_TASK" cpu/task"
srun -n $nmpi python $prog_work $ladate
echo "finished" `date`

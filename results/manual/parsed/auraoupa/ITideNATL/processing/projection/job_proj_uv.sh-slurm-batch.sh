#!/bin/bash
#SBATCH --job-name=projuv
#SBATCH --output=outjob_proj_uv.o%j
#SBATCH --error=outjob_proj_uv.e%j
#SBATCH --mail-user=noe.lahaye@inria.fr
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=118000
#SBATCH --time=03:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=12,HSW24

set -e
eval "$(conda shell.bash hook)"
conda activate /scratch/cnt0024/ige2071/nlahaye/conda/conda38
nmpi=$SLURM_NTASKS #$(( $SLURM_NTASKS + 1 )) # this is (dangerous) cheating
echo "now doing it" `date` "JOB ID:" $SLURM_JOBID
i_day=36 # $(seq 0 4)
var="v"
prog_name=proj_uv_ty-loop.py # proj_pres_ty-loop_local.py #
prog_work=${prog_name%".py"}.$SLURM_JOBID.py
cp $prog_name $prog_work
echo "running" $prog_work "for" $var", using" $SLURM_NNODES" nodes, "$nmpi" tasks, "$SLURM_CPUS_PER_TASK" cpu/task"
srun -n $nmpi python $prog_work $var $i_day
echo "finished" `date`

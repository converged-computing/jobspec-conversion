#!/bin/bash
#SBATCH --account=zhz18039
#SBATCH --mail-user=xiucheng.yang@uconn.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --partition=priority
#SBATCH --qos=zhz18039epyc
#SBATCH --constraint=epyc128
#SBATCH --array=1-82

echo $SLURMD_NODENAME  # display the node name
module load matlab
cd /home/xiy19029/DECODE_v2_Share/
matlab -nodisplay -nosplash -singleCompThread -r "batchDECODE_Phase3_Mapping($SLURM_ARRAY_TASK_ID, $SLURM_ARRAY_TASK_MAX);exit"; 
echo 'Finished Matlab Code at '

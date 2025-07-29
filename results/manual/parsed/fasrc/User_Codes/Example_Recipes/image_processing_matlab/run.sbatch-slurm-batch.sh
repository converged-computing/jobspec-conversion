#!/bin/bash
#SBATCH --job-name=array_test
#SBATCH --output=array_test_%a.out
#SBATCH --error=array_test_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=00:20:00
#SBATCH --array=1-3

matlab -nosplash -nodesktop -nodisplay -r "video_test('test_mv_$SLURM_ARRAY_TASK_ID.mp4');exit" 2>/dev/null

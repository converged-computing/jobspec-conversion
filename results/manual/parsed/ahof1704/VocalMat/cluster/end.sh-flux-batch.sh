#!/bin/bash
#FLUX: --job-name=lovable-nunchucks-7429
#FLUX: -c=20
#FLUX: --queue=scavenge
#FLUX: -t=43200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load MATLAB/2018b
matlab -nodisplay -nosplash -nodesktop -r "root_path='/gpfs/ysm/project/ahf38/Antonio_VocalMat/VocalMat2'; work_dir = '"$FOLDER"', analysis_path = fullfile(root_path,'vocalmat_analysis'); cd(analysis_path); run('kernel_alignment_cluster.m'), "

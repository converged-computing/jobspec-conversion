#!/bin/bash
#FLUX: --job-name=Individual_Samples_scRNA-inferCNV_CancerCellDetection-${i}
#FLUX: -c=32
#FLUX: --queue=allnodes
#FLUX: --urgency=16

declare -a StringArray=("35A4AL 35EE8L 3821AL 3B3E9L 3C7D1L 3D388L 3FCDEL 43E7BL 43E7CL 44F0AL 45CB0L 4C2E5L 4D0D2L")
for i in ${StringArray[@]}
do
    jobfile=scripts/Individual_Samples_scRNA-inferCNV_CancerCellDetection-${i}.sh
    cat <<EOF > $jobfile
source /home/regnerm/anaconda3/etc/profile.d/conda.sh
conda activate singularity
singularity exec --bind /datastore \\
                 --home $PWD \\
                 docker://regnerm/scbreast_2023:1.0.5 \\
                 R CMD BATCH '--args ${i}' scripts/Individual_Samples_scRNA-inferCNV_CancerCellDetection.R scripts/Individual_Samples_scRNA-inferCNV_CancerCellDetection-${i}.Rout
EOF
    chmod +x ${jobfile}
    sbatch --export=ALL ${jobfile}
done

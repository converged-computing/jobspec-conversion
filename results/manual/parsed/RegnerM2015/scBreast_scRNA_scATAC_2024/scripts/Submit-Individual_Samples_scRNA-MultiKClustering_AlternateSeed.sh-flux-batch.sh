#!/bin/bash
#FLUX: --job-name=Individual_Samples_scRNA-MultiKClustering_AlternateSeed-${i}
#FLUX: --queue=allnodes
#FLUX: --priority=16

declare -a StringArray=("35EE8L 3821AL 49CFCL 4B146L 4C2E5L T47D")
for i in ${StringArray[@]}
do
    jobfile=scripts/Individual_Samples_scRNA-MultiKClustering_AlternateSeed-${i}.sh
    cat <<EOF > $jobfile
source /home/regnerm/anaconda3/etc/profile.d/conda.sh
conda activate singularity
singularity exec --bind /datastore \\
                 --home $PWD \\
                 docker://regnerm/scbreast_2023:1.0.5 \\
                 R CMD BATCH '--args ${i}' scripts/Individual_Samples_scRNA-MultiKClustering_AlternateSeed.R scripts/Individual_Samples_scRNA-MultiKClustering_AlternateSeed-${i}.Rout
EOF
    chmod +x ${jobfile}
    sbatch --export=ALL ${jobfile}
done

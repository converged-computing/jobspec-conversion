#!/bin/bash
#FLUX: --job-name=cactus
#FLUX: -c=64
#FLUX: --queue=bigmem
#FLUX: -t=93000
#FLUX: --urgency=16

module --force purge
start_dir=$PWD
rsync ../../week2/data/cichlids/softmasked/* masked_assemblies
cat nj_tree > cactus_setup.txt
for i in $(ls masked_assemblies/*.softmasked.fa); do
	j=$(basename $i)
	j=${j%.softmasked.fa}
	printf "%s /data/%s\n" $j $i >> cactus_setup.txt
done
cd $USERWORK
mkdir -p cactus
cd cactus
rsync -ravz ${start_dir}/masked_assemblies .
cp ${start_dir}/cactus_setup.txt .
rsync  /cluster/projects/nn9458k/phylogenomics/week2/src/cactus-v1.3.0.sif . 
singularity exec -B $(pwd):/data cactus-v1.3.0.sif cactus  --maxCores 64 /data/jobStore /data/cactus_setup.txt /data/cichlids_all.hal --binariesMode local > ${start_dir}/cactus_1.out 2> ${start_dir}/cactus_1.err
rsync cichlids_all.hal ${start_dir}
singularity exec -B $(pwd):/data cactus-v1.3.0.sif halValidate /data/cichlids_all.hal >  ${start_dir}/halValidation.all.txt
singularity exec -B $(pwd):/data cactus-v1.3.0.sif   halStats /data/cichlids_all.hal > ${start_dir}/halStats.all.txt

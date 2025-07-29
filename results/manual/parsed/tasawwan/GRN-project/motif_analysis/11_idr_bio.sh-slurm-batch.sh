#!/bin/bash
#SBATCH --job-name=idr_bio
#SBATCH --output=slurm/idr_bio-%j.out
#SBATCH --error=slurm/idr_bio-%j.err
#SBATCH --mail-user=tasawwar_rahman@brown.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --time=01:00:00

module load python/3.6.6
module load gcc/6.2  
module load idr/2.0.2
mkdir bioreps/idr_bio
mkdir bioreps/idr_bio/logs
mkdir bioreps/idr_bio/images
cd bioreps/idr_bio
bio_replicates=(
ERR3975825_ERR3975848-ERR3975862_ERR3975871
ERR3975815_ERR3975819-ERR3975833_ERR3975864
ERR3975860_ERR3975869-ERR3975846_ERR3975875
ERR3975830_ERR3975879-ERR3975820_ERR3975827)
for i in "${bio_replicates[@]}" 
do
echo idr bio ${i%%-*} and ${i#*-} 
idr --samples ../peaks/top100k_narrowPeak/${i%%-*}_top100k_peaks.narrowPeak ../peaks/top100k_narrowPeak/${i#*-}_top100k_peaks.narrowPeak \
    --input-file-type narrowPeak \
    --output-file ${i}.narrowPeak \
    --rank p.value \
    --only-merge-peaks \
    --log-output-file ${i}.idr.log
done
for i in "${bio_replicates[@]}" 
do
echo idr bio plot ${i%%-*} and ${i#*-} 
idr --samples ../peaks/top100k_narrowPeak/${i%%-*}_top100k_peaks.narrowPeak ../peaks/top100k_narrowPeak/${i#*-}_top100k_peaks.narrowPeak \
    --input-file-type narrowPeak \
    --output-file ${i}.temp \
    --rank p.value \
    --plot
mv ${i}.temp.png ${i}.png
done
mv *.log logs
mv *.png images
rm *.temp

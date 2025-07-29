#!/bin/bash
#SBATCH --job-name=quantify_images
#SBATCH --output=quantify_tiles.out
#SBATCH --error=quantify_tiles.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=15:00:00
#SBATCH --partition=biochem,owners,normal
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

module load python/2.7.13
source $SCRIPT_DIR/env/bin/activate
module load matlab/R2017b
MATLABPATH="$IMAGING_DIR/CPlibs:$IMAGING_DIR/CPscripts"
export MATLABPATH
image_dir=$1
seq_dir=$2
roff_dir=$3
fluor_dir=$4
gv_path=$5
log_dir=$6
num_cores="20"
data_scaling="MiSeq_to_TIRFStation1"
reg_subset0="FID"
reg_subset1="anyRNA"
script=$(basename $0)
script_name=${script%.*}
log_file_suffix=".log"
err_file_suffix=".err"
mkdir -p $log_dir
echo "Submitting jobs via SLURM..."
for d in $image_dir/*
do
    d_base=$(basename $d)
    log_file=$log_dir/$d_base$log_file_suffix
    err_file=$log_dir/$d_base$err_file_suffix
    echo "Image: $d"
    echo "Generating Log Files:"
    echo $log_file
    echo $err_file
    start_time=$SECONDS
    echo "Starting quantification for $image_dir at timepoint $d_base..."
    srun python $IMAGING_DIR/CPscripts/quantifyTilesDownstream.py \
        -id $image_dir -ftd $seq_dir -rod $roff_dir -fd $fluor_dir -n $num_cores \
        -rs $reg_subset0 \
        -sf $data_scaling -gv $gv_path 1> $log_file 2> $err_file
    sleep 1  # Pause for 1 second to avoid overloading scheduler
    duration=$(( SECONDS - start_time))
    echo "Done with quantification for $image_dir at timepoint $d_base. Duration: $duration" | tee -a $log_file
done	

#!/bin/bash
#SBATCH --job-name=quantify_images
#SBATCH --output=quantify_tiles.out
#SBATCH --error=quantify_tiles.err
#SBATCH --mail-user=hannahw1@stanford.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --time=15:00:00
#SBATCH --partition=biochem,owners
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

source activate barcode_venv
module load matlab/R2017b
arr_tools_path="/home/groups/wjg/hannahw1/array_tools"
MATLABPATH=${arr_tools_path}/CPscripts/:${arr_tools_path}/CPlibs/
export MATLABPATH
image_dir=$1
seq_dir=$2
roff_dir=$3
fluor_dir=$4
gv_path=$5
num_cores="18"
data_scaling="MiSeq_to_TIRFStation1"
reg_subset0="LibRegion"
script=$(basename $0)
script_name=${script%.*}
log_dir=$image_dir/$script_name"Logs"
log_file_suffix=".log"
err_file_suffix=".err"
mkdir -p $log_dir
echo "Submitting jobs via SLURM..."
for d in $image_dir/*/
do
    d_base=$(basename $d)
    log_file=$log_dir/$d_base$log_file_suffix
    err_file=$log_dir/$d_base$err_file_suffix
    start_time=$SECONDS
    echo "Starting quantification for $image_dir at timepoint $d_base..."
    srun python /home/groups/herschla/hannahw1/array_tools_Ben/CPscripts/quantifyTilesDownstream.py \
        -id $image_dir -ftd $seq_dir -rod $roff_dir -fd $fluor_dir -n $num_cores \
        -rs $reg_subset0 \
        -sf $data_scaling -gv $gv_path 1> $log_file 2> $err_file
    #sleep 1  # Pause for 1 second to avoid overloading scheduler
    #duration=$(( SECONDS - start_time))
    echo "Done with quantification for $image_dir at timepoint $d_base. Duration: $duration" | tee -a $log_file
done	

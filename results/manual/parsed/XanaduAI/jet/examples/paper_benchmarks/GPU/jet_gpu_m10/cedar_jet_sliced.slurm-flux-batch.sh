#!/bin/bash
#FLUX: --job-name=bloated-destiny-9150
#FLUX: --exclusive
#FLUX: -t=1800
#FLUX: --urgency=16

export num_runs='10'
export max_slices='8'
export OMP_PROC_BIND='false '
export OMP_PLACES='cores '
export OMP_DYNAMIC='false '
export OMP_SCHEDULE='static '

module use /home/$USER/project/custom_modules
module load intel cmake cuda/11.1.1 cutensor/1.3.1
cd $SLURM_SUBMIT_DIR
export num_runs=10
export max_slices=8
export OMP_PROC_BIND=false 
export OMP_PLACES=cores 
export OMP_DYNAMIC=false 
export OMP_SCHEDULE=static 
OMP_NUM_THREADS=1 ./jet_cuda_sliced ../data_files/m10.json 1 > /dev/null
for sl in `seq 1 ${max_slices}`;do
    for p in 1 2 4 8 16; do
        for th in 1; do
            for i in $(seq 1 $num_runs); do
                echo "### RUN=${i} ###" >> jet_cuda_sliced_omp${th}_pthread${p}_slice${sl}.out;
                OMP_NUM_THREADS=${th} ./jet_cuda_sliced ../data_files/m10.json ${p} ${sl} >> jet_cuda_full_omp${th}_pthread${p}_slice{sl}.out
            done
        done
    done
done
touch jet_sliced_data.csv
t_samples=""
for i in $(seq 0 $(($num_runs-1))); do t_samples+="t${i},"; done
echo "OMP,PTHREAD,SLICES,${t_samples}" | sed 's/.$//' >> jet_sliced_data.csv
for i in $(ls -trah | grep jet_cuda_full_omp[1-9]); 
do 
    dat_line=$(echo $i | sed "s/omp//" | sed "s/pthread//" | sed "s/slice//" | sed "s/.out//" | awk '{split($0,a,"_"); print a[4]","a[5]","a[6]};' | tr -s '\n' ',');
    dat_line+=$(cat $i | grep "t=[0-9]" | tr '\n' ',' | sed "s/t\=//g" | sed "s/s//g" | sed 's/.$//');
    dat_line+=$(echo "");
    echo $dat_line >> jet_sliced_data.csv
done

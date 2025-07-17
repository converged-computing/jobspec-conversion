#!/bin/bash
#FLUX: --job-name=milky-latke-2678
#FLUX: --urgency=16

cd /fs/ess/PCON0022/liyang/STREAM/benchmarking/Signac
data_list="../dataset_list.txt"
cat $data_list | while read line
do
    array=(${line})
    dir=${array[0]}_dir
    job=${dir/_dir/}
    echo "Job: $job"
    rds=/fs/ess/PCON0022/liyang/STREAM/benchmarking/${dir/_dir/.RDS}
    org=${array[1]}
    echo "Organism: $org"
    echo -e "#!/bin/bash\n#SBATCH --job-name=Signac_${job}\n#SBATCH --time=07:50:59\n#SBATCH --output="Signac_${job}_%j.out"\n#SBATCH --account=PCON0022\n#SBATCH --nodes=1\n#SBATCH --ntasks-per-node=20\n#SBATCH --mem=200GB\n#SBATCH --gpus-per-node=1\n\nset -e\n\nmodule load R/4.0.2-gnu9.1\n\ncd /fs/ess/PCON0022/liyang/STREAM/benchmarking/Signac/\nstart=\$(date +%s)\nsleep 5;\n\nRscript /fs/ess/PCON0022/liyang/STREAM/benchmarking/Signac/Signac_regulons.R $rds $org ./\n\nend=\$(date +%s)\ntake=\$(( end - start ))\necho \${take}" > "${job}_Signac.pbs"
done

#!/bin/bash
#FLUX: --job-name=3sl
#FLUX: --urgency=16

OUTPUT_DIR="/explore/nobackup/projects/ilab/projects/Senegal/Distributed-Runs/$USER"
CLI_PATH="/explore/nobackup/people/jacaraba/development/senegal-lcluc-tensorflow/senegal_lcluc_tensorflow/view/landcover_cnn_pipeline_cli.py"
CONFIG_PATH="/explore/nobackup/people/jacaraba/development/senegal-lcluc-tensorflow/projects/land_cover/configs/experiments/20230309-cas-wcas-otcb"
CONTAINER="/explore/nobackup/projects/ilab/containers/tensorflow-caney-2023.05"
CONFIGS=(
	"land_cover_otcb_cas-wcas_local-std_30.yaml" 
	"land_cover_otcb_cas-wcas_local-std_40.yaml" 
	"land_cover_otcb_cas-wcas_local-std_50.yaml" 
	"land_cover_otcb_cas-wcas_rescale-perchannel.yaml"
)
DATAS=(
	"land_cover_512_otcb_30TS_cas-wcas.csv"
	"land_cover_512_otcb_40TS_cas-wcas.csv"
	"land_cover_512_otcb_50TS_cas-wcas.csv"
	"land_cover_512_otcb_30TS_cas-wcas.csv"
)
mkdir -p $OUTPUT_DIR
for i in {0..3}
do
	echo -e "#!/bin/bash\n#SBATCH -t05-00:00:00 -N1 -J 3sl --export=ALL" > $OUTPUT_DIR/${USER}_${i}.sh
	echo -e "#SBATCH -e ${OUTPUT_DIR}/slurm-%j-stderr.out" >> $OUTPUT_DIR/${USER}_${i}.sh
	echo -e "#SBATCH -o ${OUTPUT_DIR}/slurm-%j-stdout.out" >> $OUTPUT_DIR/${USER}_${i}.sh
	echo -e "#SBATCH --mail-user=jordan.a.caraballo-vega@nasa.gov" >> $OUTPUT_DIR/${USER}_${i}.sh
	echo -e "#SBATCH --mail-type=ALL\n"  >> $OUTPUT_DIR/${USER}_${i}.sh
	echo -e "module load singularity\n" >> $OUTPUT_DIR/${USER}_${i}.sh
	COMMAND="srun -n1 singularity exec --env PYTHONPATH="/explore/nobackup/people/jacaraba/development/tensorflow-caney" --nv -B /explore/nobackup/projects/ilab,/explore/nobackup/projects/3sl,$NOBACKUP,/lscratch,/explore/nobackup/people $CONTAINER python ${CLI_PATH} -c ${CONFIG_PATH}/${CONFIGS[${i}]} -d ${CONFIG_PATH}/${DATAS[${i}]} -s preprocess train predict"
	echo -e "$COMMAND" >> $OUTPUT_DIR/${USER}_${i}.sh
	sbatch $OUTPUT_DIR/${USER}_${i}.sh
done

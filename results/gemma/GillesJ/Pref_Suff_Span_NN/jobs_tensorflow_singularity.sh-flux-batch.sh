# Flux batch script equivalent

--job-name=sing_tf
--nodes=1
--ntasks-per-node=16
--gpu=1
--queue=standard
--output=sing_tf.out
--error=sing_tf.err

module load singularity
cd /extra/vikasy
singularity run --nv tf_gpu-1.2.0-cp35-cuda8-cudnn51.img /extra/vikasy/4chars_Prefix_Suffix_Experiments/Spanish/main.py
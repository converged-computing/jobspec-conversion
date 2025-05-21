# Pixi Environments

Create a flux allocation (limit is 1h)

```bash
flux alloc -N1 -q pbatch -t 1h
```

## 1. Setup

You'll need to login to Hugging Face.

```bash
huggingface-cli login  --add-to-git-credential
```

And then source the pixi env.

```bash
export PATH="/p/vast1/fractale/descriptive-thrust/pixi/bin:$PATH"
which pixi
```

I created it like this (you don't need to do this).

```bash
export PIXI_HOME=/p/vast1/fractale/descriptive-thrust/pixi
curl -fsSL https://pixi.sh/install.sh | sh
```

Then choose an environment:

 - mistral
 - ...maybe more coming soon?

## Environments

## 3. Mistral

Note that this environment was created as follows (you do not need to do this):

```bash
# And installed environments with
cd /p/vast1/fractale/descriptive-thrust/Src_fractale_de/pixi-envs/mistral
pixi install
pixi run install-pytorch-rocm62
```

Enter (shell into) the environment!

```bash
cd /p/vast1/fractale/descriptive-thrust/Src_fractale_de/pixi-envs/mistral
pixi shell
```

Export the models home:

```bash
export HF_HUB_CACHE=/p/vast1/fractale/descriptive-thrust/Src_fractale_de/models
```

Run the script. There is the command in the run.sh, and put here. Note that we aren't saving output, it's just testing.

```bash
bash run.sh

OR

python process-jobspecs.py --model mistralai/Codestral-22B-v0.1 --batch-size 4 --output-file /tmp/output.csv --oneshot --min-ccn 1.0 --max-ccn 2.0 --max-chars 16000 --max-files 100 --prompt-per-rm
```

Note that I changed max files to 100 (from 40000) since this is just a demo.

# JobSpec Conversion

Was interested this weekend to try converting our open source [jobspec database](https://github.com/converged-computing/jobspec-database) from the formats it comes in to Flux, and also to generate images that show the breakdown of a small subset of data.

## Usage

Run the generation for some number (defaults to 100):

```bash
export GEMINI_API_KEY=xxxxxxxxxxxxxxx
python generate-jobspecs.py --limit 100
```

This will generate the contents of [results](results). Then validate. For validation, we basically:

1. Use the Flux Directives Parser to read in the batch script
2. If it doesn't read in due to error, we remove the line and try again, keeping track of the deleted lines
3. After we read it, we go through each directive and further validate
4. We keep track of total correct, wrong, and changed lines (to be added to total after)
5. We plot the histogram of accuracy and also other summary metrics

If you are using Flux in a container:

```bash
docker run -it -v $PWD/:/data fluxrm/flux-sched:jammy
cd /data
sudo apt-get update && apt-get install -y python3-pandas python3-seaborn
```
You'll need this installed

```bash
cd /tmp
mkdir -p ./bin
curl -fsSL https://git.io/shellmetrics > ./bin/shellmetrics
chmod +x ./bin/shellmetrics
export PATH=$PWD/bin:$PATH
cd -
```

```bash
cd /data
python validate-jobspecs.py
```

Note that this sample is biased to those that the Gemini API can parse.

## Results

Here is a quick glimpse, just a small number for testing.

### Applications

Of the set we parsed, these are applications. This was not a random sample (the same repo is multiple times)

![gemini-jobspec-applications.png](gemini-jobspec-applications.png)

### Complexity

This is comparing the shellmetrics complexity to the LLM derived one, which I asked it to come up with based on criteria (see prompt in generation script). What I would guess here is that our result sample is biased to those with lower complexity.

![gemini-jobspec-complexity.png](gemini-jobspec-applications.png)

That said, I bet we could separate the resources part of the script from the rest, and just have the resources get parsed for the conversion (and then the script plopped in) and then use the shellmetrics complexity.

### Accuracy

This was a cool approach I think - I used the Flux Directive Parser to first try to load the script. If it didn't load, I saved the line and the reason why (see [gemini-jobspec-to-flux.json](gemini-jobspec-to-flux.json)) and deleted the line and tried again. Then I could do a second level of parsing, going through the lines and validating each one. At the end I get a total count of correct, wrong, plus deletions. The accuracy is:

```console
accuracy = correct / (total + deletions)
```

The total can't include the deleted lines that had to be removed in order to parse it.

![gemini-jobspec-to-flux-accuracy.png](gemini-jobspec-to-flux-accuracy.png)

That's it - I think I'd like to try the approach I mentioned, and also Gemma instead.

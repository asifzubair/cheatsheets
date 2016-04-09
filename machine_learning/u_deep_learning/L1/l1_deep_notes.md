# Udacity Deep Learning Course #

## L1 Machine Learning to Deep Learning ##

Already `numpy` is giving me grief, but I think as I play around with more I will get used to the conventions.  

```python
"""Softmax."""

scores = [3.0, 1.0, 0.2]

import numpy as np

def softmax(x):
    """Compute softmax values for each sets of scores in x."""
    return np.exp(x)/np.sum(np.exp(x), axis=0)
    
print(softmax(scores))

# Plot softmax curves
import matplotlib.pyplot as plt
x = np.arange(-2.0, 6.0, 0.1)
scores = np.vstack([x, np.ones_like(x), 0.2 * np.ones_like(x)])

plt.plot(x, softmax(scores).T, linewidth=2)
plt.show()
```

With staring values - `[3.0, 1.0, 0.2]` - if the scores are divided by 10 then the probabilities will get closer to uniform distribution. 
Since all the scores decrease in magnitude, the resulting softmax probabilities will be closer to each other.

**One-Hot Encoding** 

Multinomial Logistic Classification:
input [X] --> logits [Y] --> softmax [S(Y)] --> 1-hot labels

**Cross Entropy:** distance between two probability vectors - D(S,L) = -sum(L_i*log(S_i))

Define `loss` as average cross-entropy over the training set.

---

## TensorFlow Installation ##

I can't believe I am working on TensorFlow, but it seems great. I wanted to do Deep Learning for the longest time ! Installation instructions are [here](https://www.tensorflow.org/versions/master/get_started/os_setup.html#download-and-setup)

I opted for the `virtualenv` for installation. However, it was harder than I thought. I wanted to use the anaconda's `python` so used the  ```virtualenv --python=/Users/asifzubair/anaconda/bin/python venv``` which gave me a stinking error. It seems that there is a problem with `pip` and conda's `python` - see this open [issue](https://github.com/conda/conda/issues/1367) and [SO](http://stackoverflow.com/questions/30812290/tox-conda-travis-ci-raises-importerror-pyerr-replaceexception). The suggestion, if you want to use `virtualenv` with conda, is to downgrade python version `conda install python=2.7.9`. Conda should fix this! 

Also, this [page](https://doughellmann.com/blog/2008/02/01/ipython-and-virtualenv/) has some ideas on making `virtualenv` and `ipython` work together. 

When I upgraded the `virtualenv` using `pip`, `conda` said that `virtualenv` has not been tested. So, I am using `conda` for creating a virtual environment. This [page](http://conda.pydata.org/docs/_downloads/conda-pip-virtualenv-translator.html) has a helpful comparison.

conda will sometimes give SSL error - just do [this](https://github.com/conda/conda/issues/1166).

I'm still not satisfied with my installation. Will look at it later.

I also thought of the running docker as this [page](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/examples/udacity/README.md) advises, but their memory requirement is `8gb` and I have only 8gb on the machine. Also, what is interesting is that while running the docker container is easy 

```
docker run -p 8888:8888 -it --rm b.gcr.io/tensorflow-udacity/assignments
```
very few tutorials on actually stopping it - [this](https://www.ctl.io/developers/blog/post/gracefully-stopping-docker-containers) could be promising. 

on Mac, we need to figure out the IP `docker` is broadcasting on:

```
docker-machine ip default
```

**conda FTW**  

I didn't think it would end this way but it did ! I used conda's `create` command for setting up a virtual env and then installed tensorflow and jupyter.

The trick is that after creating the environment we need to uninstall `setuptools`. I think `tensorflow` uses `pip` to do this and fails. This is because the package wasn't installed using `pip` in the first place. I have to say - this [tutorial](http://kylepurdon.com/blog/using-continuum-analytics-conda-as-a-replacement-for-virtualenv-pyenv-and-more.html) really helped!  

For posterity, my steps were:

```
conda create -n tensorflow python
source activate tensorflow
conda list
conda remove setuptools
pip install --upgrade https://storage.googleapis.com/tensorflow/mac/tensorflow-0.6.0-py2-none-any.whl
conda install jupyter
conda list
jupyter notebook
source deactivate
```

---

Vncent V introduced a concept that I had some difficulty coming to terms with. I understood the idea of Cross-Validation, but I was having trouble understanding **Validation and Test Set**. Vincent explained it very well. 
He says that when we train and test classifier - over time as we run many experiments, the test set bleeds into the training set - through user decisions. To eliminate this, he advises a three-way split of the data - training, validation and testing.  

We would train and validate the classifier on the training and validation set respectively, and some of the validation set will bleed into the test set but that is okay because we will always have the test set that we have well hidden from the classifier. 


**rule of thumb:** a change that affects 30 examples in your validation set either way is statistically significant and can be trusted. 

This rule of thumb dictates that we can hold back 30000 examples to see a call a change in accuracy of 0.1% as significant. However, this only holds when the classes are balanced, and if some important classes are rare - this heuristic is no good. 

**Stochastic Gradient Descent**

**rule of thumb:** if computing the loss function takes `n` floating point operations, computing its gradient takes three times that compute. 

So, since gradient descent is constly, so we estimate it - badly. Instead of computing the average loss for the the whole training data, we compute it over a small random sample and use that sample to compute the gradient.

SGD scales well with both data nd model size. 

Helping SGD:  

- inputs  
    - zero mean and equal variance  
- initial weights  
    - random weights with relatively small variance  


## Need To Redo ##
**momentum**  
**learning rate decay**  
**learning rate tuning**  

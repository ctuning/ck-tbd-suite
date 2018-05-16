[![logo](https://github.com/ctuning/ck-guide-images/blob/master/logo-powered-by-ck.png)](https://github.com/ctuning/ck)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

This [CK](https://github.com/ctuning/ck) repository provides automated, portable and customizable workflows
for [AI/ML benchmarks](https://github.com/tbd-ai/tbd-suite). We suggest you to look 
at this [Getting started guide](https://github.com/ctuning/ck/wiki/First-feeling) before using CK.

## Minimal CK installation

The minimal installation requires:

* Python 2.7 or 3.3+ (limitation is mainly due to unitests)
* Git command line client.

You can install CK in your local user space as follows:

```
$ git clone http://github.com/ctuning/ck
$ export PATH=$PWD/ck/bin:$PATH
$ export PYTHONPATH=$PWD/ck:$PYTHONPATH
```

You can also install CK via PIP with sudo to avoid setting up environment variables yourself:

```
$ sudo pip install ck
```

## Install this CK repository

```
$ ck pull repo:ck-tbd-suite
```

Note that CK will download other CK repositories with required dependencies including TensorFlow and ImageNet CK packages.

If you already have CK and repositories installed, we suggest you to update them as follows:
```
$ ck update all
```

## Detect and test CUDA

```
$ ck detect platform.gpgpu --cuda
```

If you are prompted to choose a platform description, select the one the name of which is the same or similar to your platform or `generic-linux`.

## Install or detect ImageNet dataset

Before running AI/ML benchmarking via CK, you need to install ImageNet data sets or detect already installed ones.

You can install ImageNet training data set (~150GB) via CK as follows:
```
$ ck install package:imagenet-2012-train
```

Alternatively, you can detect already installed training set as follows:
```
$ ck detect soft:dataset.imagenet.train --search_dirs={root path to your training dataset}
```

In the same way, you can install ImageNet validation data set (~10GB) via CK
```
$ ck install package:imagenet-2012-val
```
or detect already installed one as follows:
```
$ ck detect soft:dataset.imagenet.val --search_dirs={root path to your validation dataset}
```

You can see all registered environments in the CK as follows:
```
$ ck show env
```

# Install TF

You can install different versions of TF via CK as follows:
```
$ ck install package --tags=lib,tensorflow
```

For example, you can install prebuilt CUDA version of TensorFlow 1.8.0 as follows:
```
$ ck install package:lib-tensorflow-1.8.0-cuda
```

## Run image classification training using TF

Now you can try to run image classification training using TF as follows:
```
$ ck run program:image-classification-tensorflow
```

You need to select a specific command line:
* train (default benchmarking)
* train-and-profile (to use nvprof)
* train-and-profile-fp32 (to use nvprof & fp32)

You can also customize your trianing run as follows:
```
$ ck run program:image-classification-tensorflow --env.LEARNING_OPTIMIZER=sgd \
   --env.BATCH_SIZE=32 \
   --env.LEARNING_RATE=0.1 \
   --env.LEARNING_RATE_DECAY_FACTOR=0.1 \
   --env.NUM_EPOCHS_PER_DECAY=30 \
   --env.WEIGHT_DECAY=0.0001
```

## Next steps

We are now preparing CK modules to perform exploration of above parameters and save results 
in a [ReQuEST format](http://cKnowledge.org/request) to visualize them 
via [live CK scoreboard](http://cKnowledge.org/repo).

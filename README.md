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

## Detect all platform parameters in a unified way

```
$ ck detect platform
```

## Install or detect ImageNet dataset

Before running AI/ML benchmarking via CK, you need to install ImageNet data sets or detect already installed ones.

Just for a test, you can install a tiny ImageNet training data set (several MB) via CK as follows:
```
$ ck install package:imagenet-2012-train-min
```

You can later install a full ImageNet training data set (~150GB) via CK which will co-exist with the above one as follows:
```
$ ck install package:imagenet-2012-train
```

Alternatively, you can detect already installed training sets as follows:
```
$ ck detect soft:dataset.imagenet.train --search_dirs={root path to your training dataset}
```

In the same way, you can install a small demo ImageNe validation data set (a few MB) via CK:
```
$ ck install package:imagenet-2012-val-min
```

and later full ImageNet validation data set (~10GB) via CK
```
$ ck install package:imagenet-2012-val
```
or detect already installed ones as follows:
```
$ ck detect soft:dataset.imagenet.val --search_dirs={root path to your validation dataset}
```

You can see all registered virtual environments in the CK as follows:
```
$ ck show env
```

# Install TF

You can install different versions of TF via CK as follows:
```
$ ck install package --tags=lib,tensorflow
```

For example, you can install pre-built CUDA version of TensorFlow 1.8.0 if you have CUDA >=9.0 as follows:
```
$ ck install package:lib-tensorflow-1.8.0-cuda
```

or TensorFlow 1.4.0 if you have CUDA < 9.0 as follows:
```
$ ck install package:lib-tensorflow-1.4.0-cuda
```

## Prepare training set of TF

You can now convert your tiny demo ImageNet training set to a TF format as follows:
```
$ ck install package:imagenet-2012-train-tf-min
```
and/or the full one as follows:
```
$ ck install package:imagenet-2012-train-tf
```

However processing of the full training set requires a large amount of disk space (~100GB) 
and execution time (hours and even days), you can detect already processed training set 
in the TF format as follows (for example on a shared drive):

```
$ ck detect soft:dataset.imagenet.train.tf
```

## Run image classification training using TF

Now you can try to run image classification training using TF as follows:
```
$ ck run program:image-classification-inception-tf
```

You need to select a specific command line:
* train (default benchmarking)
* train-and-profile (to use nvprof)
* train-and-profile-fp32 (to use nvprof & fp32)

You can also customize your training run as follows:
```
$ ck run program:image-classification-tensorflow --env.LEARNING_OPTIMIZER=sgd \
   --env.BATCH_SIZE=32 \
   --env.LEARNING_RATE=0.1 \
   --env.LEARNING_RATE_DECAY_FACTOR=0.1 \
   --env.NUM_EPOCHS_PER_DECAY=30 \
   --env.WEIGHT_DECAY=0.0001 \
   --env.MAX_NUMBER_OF_STEPS=1000
```

You can clean all temporal check points by adding "--clean" flag:
```
$ ck run program:image-classification-tensorflow --clean
```

To run a small test use the following command line:
```
$ ck run program:image-classification-tensorflow --env.BATCH_SIZE=2 --env.MAX_NUMBER_OF_STEPS=100
```

## Next steps

We plan to add a CK package for a smaller training set (to validate the functionality of this workflow),
CK module to expose or calculate accuracy of a final model,
and automate collection and processing of nvprof statistics.

We also plan to prepare CK modules to perform exploration of above parameters and save results 
in a [ReQuEST format](http://cKnowledge.org/request) to visualize them 
via [live CK scoreboard](http://cKnowledge.org/repo).

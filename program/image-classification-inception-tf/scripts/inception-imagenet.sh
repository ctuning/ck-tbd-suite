DATASET_DIR=${CK_ENV_DATASET_IMAGENET_TRAIN_TF} # path to your TFRecords folder
TRAIN_DIR=./log

if [ "$1" = "" ]
then
        PREFIX=
        SUFFIX=

elif [ "$1" = "--profile" ]
then
        mkdir -p measurements
        PREFIX="${CK_ENV_COMPILER_CUDA_BIN}/nvprof --profile-from-start off \
                --export-profile measurements/inception-tensorflow.nvvp -f --print-summary"
        SUFFIX=" --nvprof_on=True"

elif [ "$1" = "--profile-fp32" ]
then
        mkdir -p measurements
        PREFIX="${CK_ENV_COMPILER_CUDA_BIN}/nvprof --profile-from-start off \
                --export-profile measurements/inception-tensorflow.nvvp -f \
                --metrics single_precision_fu_utilization"
        SUFFIX=" --nvprof_on=True"

else
        echo "Invalid input argument. Valid ones are --profile/--profile-fp32."; exit -1
fi

$PREFIX "${CK_ENV_COMPILER_PYTHON_FILE}" ../source/train_image_classifier.py --train_dir=$TRAIN_DIR --dataset_dir=$DATASET_DIR \
	--model_name=inception_v3 --optimizer=${LEARNING_OPTIMIZER} --batch_size=${BATCH_SIZE} \
	--learning_rate=${LEARNING_RATE} --learning_rate_decay_factor=${LEARNING_RATE_DECAY_FACTOR} --num_epochs_per_decay=${NUM_EPOCHS_PER_DECAY} \
	--weight_decay=${WEIGHT_DECAY} $SUFFIX


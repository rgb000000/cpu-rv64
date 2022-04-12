# Run all

EMU_FILE=$1
OSCPU_ROOT=$2
RISCV_BIN_FILES=`eval "find $OSCPU_ROOT/bin/non-output/riscv-tests -name "*.bin""`
CPU_BIN_FILES=`eval "find $OSCPU_ROOT/bin/non-output/cpu-tests -name "*.bin""`
RISCV_TEST_BIN_FILES=`eval "find /SSD/sqw/prj/yay/abstract-machine/test/riscv-tests/build -name "*.bin""`


mkdir log 1>/dev/null 2>&1

for BIN_FILE in $RISCV_BIN_FILES; do
    FILE_NAME=`basename ${BIN_FILE%.*}`
    printf "[%30s] " $FILE_NAME
    LOG_FILE=log/$FILE_NAME-log.txt
    touch $LOG_FILE
    $EMU_FILE -i $BIN_FILE &> $LOG_FILE
    if (grep 'HIT GOOD TRAP' $LOG_FILE > /dev/null) then
        echo -e "\033[1;32mPASS!\033[0m"
        rm $LOG_FILE
    else
        echo -e "\033[1;31mFAIL!\033[0m see $BUILD_PATH/$LOG_FILE for more information"
    fi
done
echo "ospcu riscv-test complete!"


for BIN_FILE in $CPU_BIN_FILES; do
    FILE_NAME=`basename ${BIN_FILE%.*}`
    printf "[%30s] " $FILE_NAME
    LOG_FILE=log/$FILE_NAME-log.txt
    touch $LOG_FILE
    $EMU_FILE -i $BIN_FILE &> $LOG_FILE
    if (grep 'HIT GOOD TRAP' $LOG_FILE > /dev/null) then
        echo -e "\033[1;32mPASS!\033[0m"
        rm $LOG_FILE
    else
        echo -e "\033[1;31mFAIL!\033[0m see $BUILD_PATH/$LOG_FILE for more information"
    fi
done
echo "ospcu cpu_test complete!"

for BIN_FILE in $RISCV_TEST_BIN_FILES; do
    FILE_NAME=`basename ${BIN_FILE%.*}`
    printf "[%30s] " $FILE_NAME
    LOG_FILE=log/$FILE_NAME-log.txt
    touch $LOG_FILE
    $EMU_FILE -i $BIN_FILE &> $LOG_FILE
    if (grep 'HIT GOOD TRAP' $LOG_FILE > /dev/null) then
        echo -e "\033[1;32mPASS!\033[0m"
        rm $LOG_FILE
    else
        echo -e "\033[1;31mFAIL!\033[0m see $BUILD_PATH/$LOG_FILE for more information"
    fi
done
echo "am riscv-test complete!"


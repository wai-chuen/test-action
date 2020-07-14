LAMBDA_URL="https://${INPUT_LAMBDA_REGION}.console.aws.amazon.com/lambda/home?region=${INPUT_LAMBDA_REGION}#/functions/"
# INPUT_LAMBDA_FUNCTION_PREFIX="scopingAPI"
# INPUT_LAMBDA_FUNCTION_SUFFIX="dev"
generate_function_name(){
    LAMBDA_FUNCTION_NAME="${INPUT_LAMBDA_FUNCTION_PREFIX}"
    if [ ! -z "$INPUT_LAMBDA_FUNCTION_SUFFIX" ]
    then
        LAMBDA_FUNCTION_NAME="${LAMBDA_FUNCTION_NAME}-${INPUT_LAMBDA_FUNCTION_SUFFIX}"
    fi
    LAMBDA_FUNCTION_NAME="${LAMBDA_FUNCTION_NAME}-$1"
}
add_to_output(){
    generate_function_name $1
    echo "Adding $LAMBDA_FUNCTION_NAME to output"
    OUTPUT_FUNCTIONS="${OUTPUT_FUNCTIONS}%0A• ${LAMBDA_URL}${LAMBDA_FUNCTION_NAME}"
}

deploy_lambda_function(){
    OUTPUT_FUNCTIONS=""
    for i in one two three four
    do
        add_to_output $i
    done
    echo $OUTPUT_FUNCTIONS
    echo "::set-output name=all_functions::$OUTPUT_FUNCTIONS"
}

deploy_lambda_function
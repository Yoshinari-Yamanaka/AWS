#!/bin/bash
TEMPLATE_FILE="cicd.yml"
STACK_NAME="CICD"
ArtifactsBucket=""

aws cloudformation deploy \
    --template-file ${TEMPLATE_FILE} \
    --stack-name ${STACK_NAME} \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
        ProjectPrefix="" \
        ArtifactsBucket=${ArtifactsBucket}

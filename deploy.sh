#!/bin/bash
S3_Bucket="SourceCode-wouldbe-put-in-this-bucket"
StackName="Watch"

#package
aws cloudformation package \
    --template-file template.yml \
    --s3-bucket ${S3_Bucket} \
    --output-template-file packaged_template.yml

#deploy
aws cloudformation deploy \
    --template-file packaged_template.yml \
    --stack-name ${StackName} \
    --parameter-overrides \
        LambdaRole=role-lambdaexec \
    --capabilities CAPABILITY_IAM


# Get resource Information
function make_json(){
PhysicalResourceId=$1
setting=$(cat << EOF
{
    "RestApiId" : "${PhysicalResourceId}"
}
EOF
)
echo ${setting} | jq > setting.json
}

if [ $? -eq 0 ] ; then
    resources=$(aws cloudformation describe-stack-resources --stack-name Watch | jq .StackResources)
    length=$(echo ${resources} | jq length)
    
    for i in $(seq 0 $((${length} - 1))) ; do
        resource=$(echo ${resources} | jq .[$i])

        LogicalResourceId=$(echo ${resource} | jq -r .LogicalResourceId)
        PhysicalResourceId=$(echo ${resource} | jq -r .PhysicalResourceId)

        if [ ${LogicalResourceId} = "APIGatewayRestApi" ] ; then
            make_json ${PhysicalResourceId}
            break
        fi
    done
fi

# if there are several potential keys would need a function to switch between them
AMAZON_KEY=${AMAZON_KEY:-~/.ssh/amazonkey.pem}
if [[ -r "$AMAZON_KEY" ]] ; then
    export EC2_PRIVATE_KEY=${EC2_PRIVATE_KEY:-~/.ssh/amazonkey.pem}
    export EC2_CERT=${EC2_CERT:-~/.ssh/amazoncert.pem}
    export AWS_CREDENTIAL_FILE=${AWS_CREDENTIAL_FILE:-~/.ssh/amazon-credential.txt}
    # need a way to set correctly this:
    export EC2_URL=${EC2_URL:-https://ec2.eu-west-1.amazonaws.com}
else
    unset AMAZON_KEY
fi
if [[ -d "/usr/local/share/ec2-api-tools" ]] ; then
    export EC2_HOME=${EC2_HOME:-/usr/local/share/ec2-api-tools}
    pathmunge $EC2_HOME/bin after
fi

if [[ -d "/usr/local/share/IAMCli" ]] ; then
    export AWS_IAM_HOME=${AWS_IAM_HOME:-/usr/local/share/IAMCli}
    pathmunge $AWS_IAM_HOME/bin after
fi



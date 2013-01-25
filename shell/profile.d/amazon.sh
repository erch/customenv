export EC2_PRIVATE_KEY=~/.ssh/amazonkey.pem
export EC2_CERT=~/.ssh/amazoncert.pem
export EC2_HOME=/usr/local/share/ec2-api-tools-1.5.2.5
pathmunge $EC2_HOME/bin after
export AWS_CREDENTIAL_FILE=~/.ssh/amazon-credential.txt
export AWS_IAM_HOME=/usr/local/share/IAMCli-1.4.0
pathmunge $AWS_IAM_HOME/bin after
export EC2_URL=https://ec2.eu-west-1.amazonaws.com
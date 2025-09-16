cd /
ls
cd home
ls
cd yeongjinking
ls
pwd
mkdir terraform
ls
cd terraform/
ls
mkdir env modules
ls
cd modules/
ls
mkdir network sg iam eks rds
ls
cd network/
ls
touch main.tf variables.tf outputs.tf
ls
vi variables.tf 
vi main.tf
vi outputs.tf
cd .
cd ..
ls
cd ..
ls
cd env/
ls
touch main.tf variables.tf outputs.tf terraform.tfvars
ls
vi variables.tf 
vi terraform.tfvars 
vi main.tf 
vi outputs.tf 
terraform init
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install terraform
terraform -v
alias t=terraform
t -v
sudo apt-get install awscli -y
aws
sudo apt install awscli -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install
ls
sudo ./aws/install
aws --version
rm awscliv2.zip
rm -rf aws
ls
aws --version
aws configure
aws sts
aws --version
aws sts get-caller-identity
t init
t plan
t apply
t destroy
ls
vi terraform.tfvars 
t apply
vi terraform.tfvars 
t apply
t destroy
cd ..
ls
cd modules/
ls
cd iam
ls
touch main.tf variables.tf outputs.tf
ls
vi variables.tf 
vi main.tf 
vi outputs.tf 
vi main.tf 
cd ..
ls
cd sg
ls
touch main.tf variables.tf outputs.tf
ls
vi variables.tf 
vi main.tf 
vi outputs.tf 
cd ..
cd env/
ls
vi main.tf 
vi outputs.tf 
terraform init -upgrade
t plan
t apply
t destroy
cd ..
ls
cd modules/
ls
cd eks
touch main.tf variables.tf outputs.tf
ls
vi variables.tf 
vi main.tf 
vi outputs.tf 
cd ..
cd rds
touch main.tf variables.tf outputs.tf
vi variables.tf 
vi main.tf 
vi outputs.tf 
cd ..
ls
cd ..
cd env/
ls
vi main.tf 
vi outputs.tf 
terraform init -upgrade
t plan
cd ..
cd modules/
cd eks/
ls
vi main.tf 
cd ..
cd env/
ls
t init
t plan
ls
vi terraform.tfvars 
t plan
t apply
cd ..
cd rds
ls
cd modules/rds/
vi main.tf 
cd ..
cd env/
ls
t destroy
cd ..
cd modules/rds
ls
vi main.tf 
cd ..
cd sg
ls
vi main.tf 
cd ..
cd env/
ls
t init
t plan
t apply
t destroy
vi terraform.tfvars 
vi main.tf 
cd ..
cd modules/eks
ls
vi main.tf 
cd ..
cd env/
t plan
t apply
cd ..
cd modules/rds
ls
vi main.tf 
cd ..
cd env/
ls
t apply
t destroy
cd ..
ls
cd modules/
ls
cd network/
vi main.tf 
cd ..
ls
cd iam
vi main.tf 
cd ..
cd sg
vi main.tf 
cd ..
ls
cd rds
vi main.tf 
cd ..
ls
jcd eks
cd eks
ls
vi main.tf 
sudo apt update
sudo apt install git
git

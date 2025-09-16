terraform {
  backend "s3" {
    bucket         = "lyjking-terraform-state-bucket" 
    key            = "global/eks/terraform.tfstate"  
    region         = "ap-northeast-2"
    dynamodb_table = "lyjking-terraform-state-lock"                
    encrypt        = true
  }
}

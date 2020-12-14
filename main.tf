terraform {
 backend "s3" {
   bucket = "automate-all-the-things-terraform-state"
   key = "global/s3/terraform.tfstate"
   region = "us-east-2"
   dynamodb_table = "automate-all-the-things-terraform-locks"
   encrypt = true
   profile = "default"
   aws_access_key_id = "AKIAI465OW3YDTNC7L6Q"
   aws_secret_access_key = "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"
  }
}

provider "aws" { 
  region="us-east-2"
  aws_access_key_id = var.deployment_username
  aws_secret_access_key = var.deployment_password
  profile = "default"
}

resource "aws_s3_bucket" "terraform_state"{
    bucket = "automate-all-the-things-terraform-state"
    
    versioning {
      enabled = true  
    }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_locks" {
  name = "automate-all-the-things-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket = "hoon-tfstate"
    key = "terraform.state"
    region = "ap-northeast-2"
  }
}

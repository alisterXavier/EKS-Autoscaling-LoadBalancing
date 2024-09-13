variable "ACCESS_KEY" {
  type = string
}

variable "SECRET_ACCESS_KEY" {
  type = string
}

locals {
  account_id = data.aws_caller_identity.current.account_id
  users      = ["Pikachu", "Bulbasaur", "Charizard", "Squirtle"]
  groups = {
    "Electric" = { users : ["Pikachu"] },
    "Earth"    = { users : ["Bulbasaur"] },
    "Fire"     = { users : ["Charizard"] },
    "Water"    = { users : ["Squirtle"] }
  }

  public_subnets = [
    {
      az   = "us-east-1a",
      cidr = "10.0.8.0/23"
    },
    {
      az   = "us-east-1b",
      cidr = "10.0.10.0/23"
    }
  ]

  private_subnets = [
    {
      az   = "us-east-1a",
      cidr = "10.0.0.0/22"
    },
    {
      az   = "us-east-1b",
      cidr = "10.0.4.0/22"
    }
  ]
}

data "aws_caller_identity" "current" {}

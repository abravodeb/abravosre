terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {}

resource "aws_key_pair" "admin_key" {
  key_name   = "admin_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBVemWV3cVLsBq7PgTklI9RXRZFXUM46mwg+EQp5dj+M4EUHWbTz82RwrKsdOIpUiHWi1KEiHPA0xHBPW9lmsYfgmRdN1mQVQOLNJuRMdNanuwYMxn1HTrGj80SYSq20QdEy6Ai4ntXVGupTSD9orQCwZ3nFSnrKAHa2PSbVd5xWI9chAsG50mNcjMehFX/L7AWaqTiiQE+W2lomS6CgbkikBQIv9pel8kmeYDYKssCgOWVoSlAle9CZ7O8xtLudndjD3kh7jvWMNAVxJTmnsBpREu8HCdOf+tm5z5CQd3KQPkCFZTABqi5iSpG6JHQ8JFPDXPylPq4CasSHnouyDnmP2D5H71NvL93zEWLkIGa0ARvWZr7VcuEFHon5DncMdiqKVlrguvMCCuX5IM2Rs85xH7tVzgoDoYS/eKLKZbTiEGDD04uZPLhwTh/z04HfU9hFkFj0nLkavg0f72bJBoVPp0CwpJhaGSJkWkF8tEAuWQAelTNu9fOzFkQHzm3uM= abravo@DESKTOP-1UFUGC8"
}

resource "aws_instance" "talana_server" {
	ami = "ami-033b95fb8079dc481"
	instance_type = "t2.xlarge"
    tags = {
		Name = "Talana Test"
	}
  key_name = "admin_key"

  root_block_device {
    volume_size = 30 
    volume_type = "gp3"
    encrypted   = false
  }

}

output "IP" {
  value = aws_instance.talana_server.public_ip
}
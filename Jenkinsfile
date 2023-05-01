def getTerraformpath() {
  return "${tool 'terraform'}/bin"
}

pipeline{
    agent any
    environment {
      PATH = "${PATH}:${getTerraformpath()}"
    }

    stages{
	stage ('Checkout'){
       	   steps {
       		 git branch: 'main', url: 'https://github.com/mohgithub27/terraform-scripts-infrastructure-as-code.git'
      }

        stage ('terraform init'){
            steps{
                sh "terraform init"
            }
        }
        stage ('terraform plan'){
            steps{
                sh "terraform plan"
            }
        }
        stage ('terraform apply'){
            steps{
                sh "terraform apply -auto-approve"
            }
        }
    }
}



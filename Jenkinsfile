def getTerraformpath() {
  return "${tool 'terraform'}/bin"
}

pipeline{
    agent any
    tools {
        git 'git'
        terraform 'terraform'
    }

    environment {
      PATH = "${PATH}:${getTerraformpath()}"
    }

    stages{
        stage ('terraform init'){
          steps{
            sh "terraform init"
          }
        }
    }
}


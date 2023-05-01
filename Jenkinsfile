pipeline{
    agent any
    environment {
      PATH = "${PATH}:${getTerraformpath()}"
        }

    stages{
        stage ('terraform init'){
          steps{
            sh" terraform init"
          }
    }
}


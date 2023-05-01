pipeline{
    agent any
    options {
      gitTool 'Default'
    }
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
}

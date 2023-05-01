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
def getTerraformpath(){
  def tfHome = tool name: '', type: 'org.jenkinsci.plugins.terraform.TerraformInstallation',
  return tfHome
}

pipeline {
  agent any

  stages {
    stage('Clone Code') {
      steps {
        git branch: 'develop', url: 'https://github.com/aartik17/myapp-devops-pipeline.git'
      }
    }

    stage('Build & Push Docker Image') {
      steps {
        sh 'chmod +x scripts/build_and_push.sh'
        sh './scripts/build_and_push.sh'
      }
    }

    stage('Terraform Apply') {
      steps {
        dir('infra') {
          sh 'terraform init'
          sh 'terraform apply -auto-approve'
        }
      }
    }

    stage('Deploy with Ansible') {
      steps {
        sh 'ansible-playbook -i ansible/hosts.ini ansible/deploy.yml'
      }
    }
  }
}

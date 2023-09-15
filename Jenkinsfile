pipeline {
    agent {
		label 'linux'
		}
    tools{
        maven "maven 3.9.4"
    }
    stages {
        stage('Clone the repository') {
            steps {
               git branch: 'master', url: 'https://github.com/ELPDevOps/Batch-5.git'
            }
        }
        stage('Build the maven code') {
            steps {
                sh 'mvn clean install'
           }
        }
        stage('Static code analysis') {
            steps {
        withSonarQubeEnv('sonarqube') {
                    sh  "mvn sonar:sonar"
                }
                }
            }
        stage('Push the artifacts into Jfrog artifactory') {
            steps {
              rtUpload (
                serverId: 'artifactory',
                spec: '''{
                      "files": [
                        {
                          "pattern": "*.war",
                           "target": "DevOpsBatch5/"
                        }
                    ]
                }'''
              )
          }
        }
        stage('Deploy to tomcat') {
            steps {
			 sh "pwd"
             sh "./deploy.sh"

        }
    }
}
}

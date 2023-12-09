pipeline {
  agent any

  stages {
      stage('Build Artifact') {
            steps {
              sh "mvn clean package -DskipTests=true"
              //archive 'target/*.jar' 
			  //new command for create artifact
			  //test
				archiveArtifacts 'target/*.jar'
			}
        }
		stage('Unit Tests - JUnit and Jacoco') {
			  steps {
				sh "mvn test"
			  }
			  post {
				always {
				  junit 'target/surefire-reports/*.xml'
				  jacoco execPattern: 'target/jacoco.exec'
				}
			  }
		}
		
		stage('SonarQube - SAST') {
			  steps {
				sh "mvn sonar:sonar -Dsonar.projectKey=numeric-application -Dsonar.host.url=http://34.101.94.171:9000 -Dsonar.login=60cb623c73313fb367038ab04edcde07e7afa163  "
			  }
			 
		}
		
		stage('Docker Build and Push') {
		  steps {
			withDockerRegistry([credentialsId: "docker-hub", url: ""]) {
			  sh 'printenv'
			  sh 'docker build -t kukuh66/numeric-app:""$GIT_COMMIT"" .'
			  sh 'docker push kukuh66/numeric-app:""$GIT_COMMIT""'
			}
		  }
		}
		
		stage('Kubernetes Deployment - DEV') {
		  steps {
			withKubeConfig([credentialsId: 'kubeconfig']) {
			  sh "sed -i 's#replace#kukuh66/numeric-app:${GIT_COMMIT}#g' k8s_deployment_service.yaml"
			  sh "kubectl apply -f k8s_deployment_service.yaml"
			}
		  }
		}
		
    }
}
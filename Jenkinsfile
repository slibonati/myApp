pipeline {
 agent any
 environment {
  dotnet = '/usr/bin/dotnet'
 }
 stages {
  stage('Checkout') {
   steps {
    echo 'check out src'
    git url: 'https://github.com/slibonati/myApp', branch: 'master'
   }
  }
  stage('Restore PACKAGES') {
   steps {
    //bat &quot;dotnet restore --configfile NuGet.Config&quot;
    sh 'dotnet restore'
   }
  }
  stage('Clean') {
   steps {
       echo 'clean'
     sh 'dotnet clean'
   }
  }
  stage('Build') {
   steps {
     echo 'building'
    sh 'dotnet build --configuration Release'
   }
  }
  stage('Pack') {
   steps {
        echo 'pack'
    sh 'dotnet pack --no-build --output nupkgs /p:OutputPath=bin/Release/netcoreapp3.1/'
   }
  }
  stage('Publish') {
   steps {
        echo 'publish'
    sh 'dotnet nuget push **\\nupkgs\\*.nupkg -s http://localhost:8089/repository/nuget-hosted/'
   }
  }
 }
}

wrappedNode(label: 'docker') {
  deleteDir()
  stage "checkout"
  checkout scm

  tokens = "${env.JOB_NAME}".tokenize('/')
  org = tokens[0]
  repo = tokens[1]
  branch = tokens[2]
  pr = "${env.CHANGE_ID}"
  echo "running ${pr}, job ${env.BUILD_ID}"
  sh "env"

  try {
    documentationChecker("docs")
  } catch (err) {
    slackSend channel: '#docs-automation', message: "BUILD FAILURE: @${env.CHANGE_AUTHOR} - <${env.CHANGE_URL}|${repo} PR#${pr}> : ${env.CHANGE_TITLE}- see <${env.BUILD_URL}/console|the Jenkins console for job ${env.BUILD_ID}>"
    throw err
  }
}

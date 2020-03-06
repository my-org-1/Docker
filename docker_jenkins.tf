# This image build process described in this file should be handled somewhere else, probably at a company level.
# The Jenkins deployment (that also occurs in this root...see main.tf) should simply consume a company image, rather than build it.
# Until there is infrastructure or a process that builds the image somewhere else, we can develop/build/push it from here.
# I imagine as soon as we have a company/infrastructure jenkins installation (perhaps built by this repo), one of the first jobs that
#    will be created will be a job that polls the jenkins image repository for changes and builds/pushes it up for others' consumption.
# I wanted this code to be as decoupled from our deployment as possible, ready to migrate back to its own repository.
# So, I put it in a separate file.

# Creates an ECR image repository to hold the jenkins image.
#resource "aws_ecr_repository" "jenkins" {
 # name = local.jenkins_ecr_repo_name
#}

# Builds and pushes the jenkins image to ECR.  See notes on resource above.
# Since this image is being actively developed, a trigger was added that effectively forces a rebuild of the image each 'terraform apply'
# No worries, docker makes use of a cache, so rebuilding the image with no changes essentially only pushes a tag to ECR.
resource "null_resource" "build_jenkins_image" {
  triggers = {
    always = uuid()
  }
  provisioner "local-exec" {
    command = "chmod -R 755 ./docker_jenkins && cd docker_jenkins && ./deploy-image.sh ${aws_ecr_repository.jenkins.repository_url} ${local.jenkins_ecr_repo_name}"
  }
}

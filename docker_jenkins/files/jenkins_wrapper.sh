#! /bin/bash -e

# Set AWS CLI region
aws configure set region `curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/[a-z]$//'`

# Restore jenkins_home from S3.  Note:  there is no --delete flag in this command; if there is no existing backup, nothing will be overwritten.
aws s3 sync s3://$JENKINS_STATE_BUCKET/jenkins_home /var/jenkins_home
chown -R jenkins:jenkins /var/jenkins_home
eval $(aws ecr get-login --region us-east-1 | sed 's/ -e none//')

#sed -i -e "s|OAUTH_CLIENT_ID|$OAUTH_CLIENT_ID|" -e "s|OAUTH_CLIENT_SECRET|$OAUTH_CLIENT_SECRET|" /var/wont_persist/casc_configs/github-oauth.yaml

# Create cron job to push our jenkins_home to s3.  This is a docker anti-pattern.
echo "* * * * * /usr/local/bin/aws s3 sync /var/jenkins_home s3://$JENKINS_STATE_BUCKET/jenkins_home --exclude '/var/jenkins_home/workspace/*' --exclude '/var/jenkins_home/caches/*' --delete --no-follow-symlinks" | crontab
service cron start

# Start Jenkins
#su -c "/sbin/tini -s -- /usr/local/bin/jenkins.sh" jenkins
gosu jenkins "/usr/local/bin/jenkins.sh"

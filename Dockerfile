FROM jenkins/jenkins:lts-alpine
LABEL maintainer="Julian Nonino <noninojulian@outlook.com>"

# Install Plugins
COPY plugins/*.txt /tmp/plugins/
RUN for plugins_file in /tmp/plugins/*.txt ; do /usr/local/bin/install-plugins.sh < $plugins_file ; done
# 
# Init scripts
COPY groovy_scripts/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# Copy default jobs, please check README.md to know how to add your own jobs
COPY jobs /usr/share/jenkins/ref/jobs

# Change owner of keys and disable initial wizard
RUN echo lts > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    echo lts > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
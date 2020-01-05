From docker:latest

# By default, Docker containers run as the root user. This is bad because:
#   1) You're more likely to modify up settings that you shouldn't be
#   2) If an attacker gets access to your container - well, that's bad if they're root.
# Here's how you can run change a Docker container to run as a non-root user

## CREATE APP USER ##

# Create the home directory for the new app user.
RUN mkdir -p /home/dockeruser

# Create an app user so our program doesn't run as root.
RUN groupadd -r dockergroup &&\
    useradd -r -g dockergroup -d /home/dockeruser-s /sbin/nologin -c "Docker image user" dockeruser

# Set the home directory to our app user's home.
ENV HOME=/home/dockeruser
ENV APP_HOME=/home/dockeruser/my-project

## SETTING UP THE APP ##
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# ***
# Do any custom logic needed prior to adding your code here
# ***

# Copy in the application code.
#ADD . $APP_HOME

# Chown all the files to the app user.
RUN chown -R dockeruser:dockergroup $APP_HOME

# Change to the app user.
USER dockeruser


FROM tomcat:8.0-alpine


# By default, Docker containers run as the root user. This is bad because:
#   1) You're more likely to modify up settings that you shouldn't be
#   2) If an attacker gets access to your container - well, that's bad if they're root.
# Here's how you can run change a Docker container to run as a non-root user

## CREATE APP USER ##

# Create an app user so our program doesn't run as root.
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set the home directory to our app user's home.
#ENV HOME=/home/AppUser
#ENV APP_HOME=/home/AppUser/my-app

# ***
# Do any custom logic needed prior to adding your code here
# ***


# Chown all the files to the app user.
RUN chown -R appuser:appgroup /usr/local/tomcat

# Copy in the application code.
ADD SampleWebApp.war /usr/local/tomcat/webapps/

# Port d'écoute
EXPOSE 8080


# Change to the app user.
USER appuser

CMD ["catalina.sh", "run"]

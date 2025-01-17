# Use an official Maven image to build the app
FROM maven:3.6.3-jdk-8 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and install dependencies
COPY pom.xml .

RUN mvn install

# Copy the entire project
COPY . .

# Package the project
RUN mvn package

# Run the app
CMD ["java", "-jar", "/app/target/gs-maven-0.1.0-shaded.jar"]

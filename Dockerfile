# Build stage
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /app
COPY email-writer-backend/pom.xml .
COPY email-writer-backend/src ./src
RUN mvn -q -DskipTests package

# Run stage
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar ./app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]

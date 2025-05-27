#Stage 1 build the application
FROM maven:3.9.9-amazoncorretto-8-debian-bookworm AS build
WORKDIR /app
COPY . .
RUN mvn clean install
#Stage 2 running the application 
FROM eclipse-temurin:8u452-b09-jre-ubi9-minimal
WORKDIR /app
COPY --from=build /app/target/*app app.jar
EXPOSE 8080 
ENTRYPOINT [ "java","-jar","app.jar" ]
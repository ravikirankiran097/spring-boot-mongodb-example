#Build JAR file using Maven
FROM maven as build
WORKDIR /spring_app
COPY . .
RUN mvn clean install

#Create Docker Image
FROM adoptopenjdk/openjdk11:jre-11.0.10_9-alpine
WORKDIR /spring_app
COPY --from=build /spring_app/target/*.jar /spring_app/*.jar
EXPOSE 8095
ENTRYPOINT ["java","-jar","*.jar"]

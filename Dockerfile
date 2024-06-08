#FIRST STAGE (BUILD)

FROM gradle AS build

WORKDIR /app

COPY . .

RUN gradle build --no-daemon 

#FINAL STAGE (RUN ON JDK)

FROM openjdk:17 

EXPOSE 8080

WORKDIR /app

COPY --from=build /app/build/libs/*.jar /app/spring-boot-application.jar

ENTRYPOINT ["java","-jar","/app/spring-boot-application.jar"]
FROM docker.io/library/gradle:6.9-jdk8@sha256:571312a1555f5a43305e3a73505c1786c335e8acc441495a396f054194327885
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon 


EXPOSE 8080

RUN mkdir /app

RUN cp /home/gradle/src/build/libs/*.jar /app/spring-boot-application.jar

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/spring-boot-application.jar"]

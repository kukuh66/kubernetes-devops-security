FROM adoptopenjdk/openjdk8:alpine-slim AS build
WORKDIR /app
COPY . .
RUN ./mvnw package

# Stage 2: Run stage
FROM adoptopenjdk/openjdk8:alpine-slim
EXPOSE 8080
RUN addgroup -S pipeline && adduser -S k8s-pipeline -G pipeline
WORKDIR /home/k8s-pipeline
COPY --from=build /app/target/*.jar app.jar
USER k8s-pipeline
ENTRYPOINT ["java","-jar","app.jar"]

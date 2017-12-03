FROM jaegertracing/all-in-one
FROM centos:7
EXPOSE 5775/udp
EXPOSE 6831/udp
EXPOSE 6832/udp
EXPOSE 5778
EXPOSE 14268
EXPOSE 16686
COPY --from=0 /go/src/jaeger-ui-build /go/src/jaeger-ui-build
COPY --from=0 /go/bin/ /go/bin/
RUN chgrp -R 0 /go/src/jaeger-ui-build
RUN chmod -R g+rw /go/src/jaeger-ui-build
RUN chgrp -R 0 /go/bin/
RUN chmod -R g+rwx /go/bin/
RUN useradd -u 10001 scratchuser
USER 10001
CMD ["/go/bin/standalone-linux","--span-storage.type=memory","--query.static-files=/go/src/jaeger-ui-build/build/"]

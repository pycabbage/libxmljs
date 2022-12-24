# Building

```bash
docker buildx build . --cache-to=type=local,dest=/tmp/buildx.cache --cache-from=type=local,src=/tmp/buildx.cache --build-arg=NODE_VERSION=18 --load -t libxmljs
docker run --name libxmljs_build -d libxmljs
docker cp libxmljs_build:/dist/ .
docker rm libxmljs_build
```

then `./dist/` contains the built files.

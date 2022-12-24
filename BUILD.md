# Building

```bash
docker buildx build . --cache-to=type=local,dest=/tmp/buildx.cache --cache-from=type=local,src=/tmp/buildx.cache
```

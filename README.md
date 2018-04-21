This image is based on the latest [rwasa](https://2ton.com.au/rwasa/) http server.

Run the container, binding a directory to serve from to `/var/www`.

```
docker run -d -p 8080:8080 -v /path/to/serve:/var/www scttmthsn/rwasa
```

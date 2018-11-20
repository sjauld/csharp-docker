# Mono is an open source implementation of Microsoft's .NET Framework based on
# the ECMA standards for C# and the Common Language Runtime.
#
# https://www.mono-project.com/
FROM mono as intermediate

WORKDIR /app

COPY . /app

RUN xbuild

# Full mono is 605 MB, slim mono is 220 MB. Still pretty big! You could also
# consider using frolvlad/alpine-mono which is 130MB.
FROM mono:slim

LABEL maintainer="Stuart Auld <stu@aceteknologi.com>"

COPY --from=intermediate /app/hello.cs.exe /app/app.exe

WORKDIR /app

ENTRYPOINT ["mono"]

CMD ["app.exe"]

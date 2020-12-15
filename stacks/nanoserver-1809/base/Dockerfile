FROM mcr.microsoft.com/windows/nanoserver:1809

# copy required DLL for golang os/user and sys/windows package: https://github.com/microsoft/Windows-Containers/issues/72
COPY --from=mcr.microsoft.com/windows/servercore:1809 /Windows/System32/NetApi32.dll /Windows/System32/NetApi32.dll

# non-zero sets all user-owned directories to BUILTIN\Users
ARG cnb_uid=1
ARG cnb_gid=1

ENV CNB_USER_ID=${cnb_uid}
ENV CNB_GROUP_ID=${cnb_gid}

# launcher requires a non-empty PATH
ENV PATH c:\\Windows\\system32;C:\\Windows

USER ContainerUser

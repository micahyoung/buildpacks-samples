# Sample Nanoserver 1809 Builder

### Prerequisites
* Docker Desktop with Windows Containers and support for 1809 images

### Usage

#### Creating the builder

```bash
pack create-builder cnbs/sample-builder:nanoserver-1809 --config builder.toml 
```

#### Build app with builder

```bash
pack build sample-app --builder cnbs/sample-builder:nanoserver-1809 --path ../../apps/batch-script/
```

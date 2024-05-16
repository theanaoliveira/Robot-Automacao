# Build image:

```
docker build -t robot-framework .  
```

# Run tests:

```
docker run -it --rm -v $(pwd):/app -v $(pwd)/results:/project/results robot-framework bash -c "robot --outputdir /project/results  /app/tests"
```
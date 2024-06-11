[1mdiff --git a/.github/workflows/docker-image.yml b/.github/workflows/docker-image.yml[m
[1mnew file mode 100644[m
[1mindex 0000000..84052b9[m
[1m--- /dev/null[m
[1m+++ b/.github/workflows/docker-image.yml[m
[36m@@ -0,0 +1,46 @@[m
[32m+[m[32mname: Docker Image CI[m
[32m+[m
[32m+[m[32mon:[m
[32m+[m[32m  push:[m
[32m+[m[32m    branches: [ "main" ][m
[32m+[m[32m  pull_request:[m
[32m+[m[32m    branches: [ "main" ][m
[32m+[m
[32m+[m[32mjobs:[m
[32m+[m
[32m+[m[32m  build:[m
[32m+[m[32m    runs-on: ubuntu-latest[m
[32m+[m
[32m+[m[32m    steps:[m
[32m+[m[32m    - name: Checkout code (Step 1)[m
[32m+[m[32m      uses: actions/checkout@v4[m
[32m+[m[32m      with:[m
[32m+[m[32m        fetch-depth: 0[m
[32m+[m[41m        [m
[32m+[m[32m    - name: Git Semantic Version[m
[32m+[m[32m      uses: PaulHatch/semantic-version@v4.0.3[m
[32m+[m[32m      with:[m
[32m+[m[32m        major_pattern: "major:"[m
[32m+[m[32m        minor_pattern: "feat:"[m
[32m+[m[32m        format: "${major}.${minor}.${patch}-prerelease${increment}"[m
[32m+[m[32m      id: myversion[m
[32m+[m[41m              [m
[32m+[m[32m    - name: Docker login (Step 2)[m
[32m+[m[32m      env:[m
[32m+[m[32m        DOCKER_USER: ${{ secrets.DOCKER_USER }}[m
[32m+[m[32m        DOCKER_PASSWORD: ${{ secrets.DOCKER_PASSWORD }}[m
[32m+[m[32m      run: docker login -u $DOCKER_USER -p $DOCKER_PASSWORD[m
[32m+[m[41m        [m
[32m+[m[32m    - name: Build Docker Image (Step 3)[m
[32m+[m[32m      env:[m
[32m+[m[32m        NEW_VERSION: ${{ steps.myversion.outputs.version }}[m
[32m+[m[32m      run: |[m
[32m+[m[32m        docker build -t lypthusdev/docker-graphql:$NEW_VERSION .[m
[32m+[m[32m        docker build -t lypthusdev/docker-graphql:latest .[m
[32m+[m[41m        [m
[32m+[m[32m    - name: Push Docker Image (Step 4)[m
[32m+[m[32m      env:[m
[32m+[m[32m        NEW_VERSION: ${{ steps.myversion.outputs.version }}[m
[32m+[m[32m      run: |[m
[32m+[m[32m        docker push lypthusdev/docker-graphql:$NEW_VERSION[m
[32m+[m[32m        docker push lypthusdev/docker-graphql:latest[m

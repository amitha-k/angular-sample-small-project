```dockerfile
# ============================================================
# Stage 1: Build Angular Application
# ============================================================

FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build


# ============================================================
# Stage 2: Nginx Web Server
# ============================================================

FROM nginx:alpine

# Remove default nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy Angular build files
COPY --from=build /app/dist/angular-sample-small-project/browser /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```


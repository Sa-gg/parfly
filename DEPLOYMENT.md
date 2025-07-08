# Deployment Guide

This guide covers deploying Parfly to various platforms for production use.

## 🌐 Deployment Overview

Parfly consists of multiple components that can be deployed separately:

- **Backend API**: Node.js/Express server
- **Admin Panel**: React web application  
- **Database**: PostgreSQL
- **Mobile Apps**: React Native apps via Expo

## 🖥️ Backend Deployment

### Option 1: Render (Recommended)

Render provides easy deployment for Node.js applications with built-in PostgreSQL.

#### Steps:

1. **Create Render Account**: Sign up at [render.com](https://render.com)

2. **Create Web Service**:
   - Connect your GitHub repository
   - Select `Parfly-Backend` as root directory
   - Build Command: `npm install`
   - Start Command: `npm start`

3. **Environment Variables**:
   ```
   NODE_ENV=production
   PORT=10000
   PG_USER=your_postgres_user
   PG_HOST=your_postgres_host
   PG_DATABASE=your_database_name
   PG_PASSWORD=your_postgres_password
   PG_PORT=5432
   JWT_SECRET=your_secure_jwt_secret
   TOMTOM_API_KEY=your_tomtom_api_key
   ```

4. **Database Setup**:
   - Create PostgreSQL service on Render
   - Import your database schema
   - Update connection details in environment variables

### Option 2: Railway

1. **Connect Repository**: Link your GitHub repo to Railway
2. **Configure Service**: 
   - Root directory: `Parfly-Backend`
   - Start command: `npm start`
3. **Add Environment Variables**: Same as Render configuration
4. **Deploy**: Railway will auto-deploy on commits

### Option 3: Heroku

1. **Install Heroku CLI**
2. **Create Heroku App**:
   ```bash
   heroku create parfly-backend
   ```
3. **Add PostgreSQL**:
   ```bash
   heroku addons:create heroku-postgresql:hobby-dev
   ```
4. **Set Environment Variables**:
   ```bash
   heroku config:set NODE_ENV=production
   heroku config:set JWT_SECRET=your_jwt_secret
   # ... other variables
   ```
5. **Deploy**:
   ```bash
   git subtree push --prefix=Parfly-Backend heroku main
   ```

### Option 4: VPS (Ubuntu)

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install PostgreSQL
sudo apt install postgresql postgresql-contrib

# Install PM2 for process management
sudo npm install -g pm2

# Clone and setup application
git clone https://github.com/your-username/parfly.git
cd parfly/Parfly-Backend
npm install

# Configure environment
cp .env.example .env
# Edit .env with production values

# Start with PM2
pm2 start server.js --name "parfly-backend"
pm2 startup
pm2 save

# Setup Nginx reverse proxy
sudo apt install nginx
# Configure nginx to proxy to your app
```

## 🌐 Frontend Deployment (Admin Panel)

### Option 1: Netlify (Recommended)

1. **Build Locally**:
   ```bash
   cd Parfly-Admin
   npm run build
   ```

2. **Deploy to Netlify**:
   - Drag and drop `dist` folder to Netlify
   - Or connect GitHub repository for auto-deployment

3. **Configure Redirects**: Create `public/_redirects`:
   ```
   /*    /index.html   200
   ```

4. **Environment Variables**: Set in Netlify dashboard:
   ```
   VITE_API_URL=https://your-backend-url.com
   ```

### Option 2: Vercel

1. **Install Vercel CLI**:
   ```bash
   npm install -g vercel
   ```

2. **Deploy**:
   ```bash
   cd Parfly-Admin
   vercel
   ```

3. **Configure**: Follow Vercel prompts and set environment variables

### Option 3: Firebase Hosting

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Initialize Firebase
firebase init hosting

# Build and deploy
npm run build
firebase deploy
```

## 📱 Mobile App Deployment

### Option 1: Expo Application Services (EAS)

#### Prerequisites:
```bash
npm install -g eas-cli
eas login
```

#### Configure EAS:

1. **Customer App**:
   ```bash
   cd Parfly-Customer-App
   eas build:configure
   ```

2. **Driver App**:
   ```bash
   cd Parfly-Driver-App
   eas build:configure
   ```

#### Build for Production:

```bash
# Android
eas build --platform android --profile production

# iOS
eas build --platform ios --profile production

# Both platforms
eas build --platform all --profile production
```

#### Submit to App Stores:

```bash
# Google Play Store
eas submit --platform android

# Apple App Store
eas submit --platform ios
```

### Option 2: Manual Build

#### Android:

```bash
# Customer App
cd Parfly-Customer-App
npx expo run:android --variant release

# Driver App
cd Parfly-Driver-App
npx expo run:android --variant release
```

#### iOS:

```bash
# Customer App
cd Parfly-Customer-App
npx expo run:ios --configuration Release

# Driver App
cd Parfly-Driver-App
npx expo run:ios --configuration Release
```

## 🔧 Environment Configuration

### Production Environment Variables

#### Backend (.env):
```env
NODE_ENV=production
PORT=10000
PG_USER=prod_user
PG_HOST=your-db-host.com
PG_DATABASE=parfly_prod
PG_PASSWORD=secure_password
PG_PORT=5432
JWT_SECRET=very_secure_jwt_secret_for_production
TOMTOM_API_KEY=your_production_tomtom_key
CORS_ORIGIN=https://your-admin-domain.com,https://your-landing-domain.com
```

#### Mobile Apps (.env):
```env
EXPO_PUBLIC_API_URL=https://your-backend-api.com/api
EXPO_PUBLIC_GOOGLE_MAPS_API_KEY=your_production_google_maps_key
EXPO_PUBLIC_ENV=production
EXPO_PUBLIC_APP_VERSION=1.0.0
```

## 📊 Database Migration

### From Development to Production:

1. **Export Development Data**:
   ```bash
   pg_dump -h localhost -U dev_user -d parfly_dev > parfly_backup.sql
   ```

2. **Import to Production**:
   ```bash
   psql -h production-host -U prod_user -d parfly_prod < parfly_backup.sql
   ```

### Using Database Migration Tools:

```bash
# If using migration tools like Knex or Sequelize
npm run migrate:latest
npm run seed:run
```

## 🔒 Security Configuration

### Backend Security:

1. **Enable CORS for specific domains**:
   ```javascript
   app.use(cors({
     origin: [
       'https://your-admin-domain.com',
       'https://your-landing-domain.com'
     ]
   }));
   ```

2. **Enable SSL/HTTPS**: Configure SSL certificates

3. **Environment Variables**: Never commit production secrets

4. **Rate Limiting**: Implement rate limiting for API endpoints

5. **Input Validation**: Validate all user inputs

### Database Security:

1. **Connection Security**: Use SSL connections
2. **User Permissions**: Create dedicated database users
3. **Backups**: Set up automated backups
4. **Monitoring**: Monitor database performance

## 📈 Monitoring & Analytics

### Application Monitoring:

1. **Error Tracking**: Integrate Sentry or similar
2. **Performance Monitoring**: Use New Relic or DataDog
3. **Uptime Monitoring**: Set up status checks
4. **Log Management**: Centralize logs with LogRocket or similar

### Database Monitoring:

1. **Query Performance**: Monitor slow queries
2. **Connection Pooling**: Optimize database connections
3. **Backup Verification**: Regularly test backups

## 🚀 Deployment Checklist

### Pre-Deployment:

- [ ] All environment variables configured
- [ ] Database schema updated
- [ ] API endpoints tested
- [ ] Mobile apps tested on devices
- [ ] Performance optimization completed
- [ ] Security review completed
- [ ] Backup strategy in place

### Post-Deployment:

- [ ] Verify all services are running
- [ ] Test critical user flows
- [ ] Monitor error rates
- [ ] Check database connections
- [ ] Verify external API integrations
- [ ] Test mobile app functionality
- [ ] Monitor server resources

## 🔄 CI/CD Pipeline

### GitHub Actions Example:

```yaml
# .github/workflows/deploy.yml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy-backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy to Render
        # Add deployment steps

  deploy-frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy to Netlify
        # Add deployment steps

  build-mobile:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build with EAS
        # Add mobile build steps
```

## 🆘 Troubleshooting

### Common Issues:

1. **Database Connection Errors**:
   - Check connection strings
   - Verify network access
   - Check SSL requirements

2. **API CORS Errors**:
   - Update CORS configuration
   - Check origin URLs

3. **Mobile App Build Failures**:
   - Verify all dependencies
   - Check Expo configuration
   - Update API URLs

4. **Environment Variable Issues**:
   - Double-check variable names
   - Verify values are properly set
   - Check for special characters

## 📞 Support

For deployment support:
- Check platform-specific documentation
- Review error logs carefully
- Test in staging environment first
- Contact platform support if needed

---

Happy deploying! 🚀

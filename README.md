<div align="center">
  <img src="assets/logo.png" alt="Parfly Logo" width="80"/>
  <h1>Parfly</h1>
  <p>Multi-User Courier Management System</p>
</div>

<div align="center">

[![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)](https://reactjs.org/)
[![Vite](https://img.shields.io/badge/Vite-646CFF?style=for-the-badge&logo=vite&logoColor=white)](https://vitejs.dev/)
[![React Native](https://img.shields.io/badge/React_Native-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)](https://reactnative.dev/)
[![Node.js](https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white)](https://nodejs.org/)
[![Express.js](https://img.shields.io/badge/Express.js-404D59?style=for-the-badge)](https://expressjs.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)

</div>

---

## 📖 About

Parfly is a courier delivery platform that connects customers with third-party drivers for fast, same-day parcel delivery. Built with modern web and mobile technologies.

### ✨ Features

- 📱 **Mobile Apps**: Customer and Driver apps built with React Native + Expo
- �️ **Admin Dashboard**: Web-based management panel 
- � **Real-time Tracking**: Live location tracking powered by TomTom Maps API
- 🔐 **Authentication**: Role-based access control
- 💬 **Notifications**: Real-time delivery status updates

### 🏗️ Architecture

- **Frontend**: React (Admin Panel), React Native + Expo (Mobile Apps)
- **Backend**: Node.js + Express.js
- **Database**: PostgreSQL
- **Maps**: TomTom API
- **Hosting**: Netlify (Frontend), Render (Backend)

---

## 🚀 Live Demo

### Web Applications
- **🌐 Landing Page**: [parfly.netlify.app](https://parfly.netlify.app)
- **👨‍💼 Admin Dashboard**: [parfly.netlify.app/admin](https://parfly.netlify.app/admin)

### Mobile Apps (via Expo Go)
For detailed mobile app testing instructions, please refer to the setup guides in the respective mobile app repositories:
- **📱 Customer App**: See [Parfly-Customer-App](./Parfly-Customer-App) for testing guide
- **🚛 Driver App**: See [Parfly-Driver-App](./Parfly-Driver-App) for testing guide

---

## 📱 Screenshots

<div align="center">

### Customer App
<img src="assets/1.png" alt="Customer App" width="200"/>
<img src="assets/2.png" alt="Customer App" width="200"/>
<img src="assets/3.png" alt="Customer App" width="200"/>
<img src="assets/4.png" alt="Customer App" width="200"/>

### Driver App
<img src="assets/5.png" alt="Driver App" width="200"/>
<img src="assets/6.png" alt="Driver App" width="200"/>
<img src="assets/7.png" alt="Driver App" width="200"/>
<img src="assets/8.png" alt="Driver App" width="200"/>

</div>

---

## 🛠️ Local Development

### Prerequisites
- Node.js (v18+)
- PostgreSQL
- Git

### Quick Start

1. **Clone the repository**
```bash
git clone https://github.com/Sa-gg/Parfly.git
cd Parfly
```

2. **Set up the database**
```bash
createdb parfly_db
psql -U your_username -d parfly_db -f database_schema.sql
```

3. **Backend setup**
```bash
cd Parfly-Backend
npm install
cp .env.example .env  # Configure your environment variables
npm run dev
```

4. **Admin panel setup**
```bash
cd Parfly-Admin
npm install
npm run dev
```

5. **Mobile apps setup**
```bash
# Customer App
cd Parfly-Customer-App
npm install
npx expo start

# Driver App  
cd Parfly-Driver-App
npm install
npx expo start
```

### Environment Variables

**Backend (.env)**
```env
PG_USER=your_postgres_username
PG_HOST=localhost
PG_DATABASE=parfly_db
PG_PASSWORD=your_postgres_password
PG_PORT=5432
JWT_SECRET=your_jwt_secret
TOMTOM_API_KEY=your_tomtom_api_key
PORT=3001
```

**Mobile Apps (.env)**
```env
EXPO_PUBLIC_API_URL=http://localhost:3001/api
EXPO_PUBLIC_GOOGLE_MAPS_API_KEY=your_google_maps_api_key
```

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

<div align="center">
  <p>Made with ❤️ by the Parfly Team</p>
</div>

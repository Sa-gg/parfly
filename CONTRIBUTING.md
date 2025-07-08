# Contributing to Parfly

Thank you for your interest in contributing to Parfly! This document provides guidelines and information for contributors.

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have completed the setup process outlined in the main [README.md](README.md).

### Development Environment

1. **Code Editor**: We recommend using [Visual Studio Code](https://code.visualstudio.com/) with the following extensions:
   - ES7+ React/Redux/React-Native snippets
   - Prettier - Code formatter
   - ESLint
   - Auto Rename Tag
   - Bracket Pair Colorizer
   - Thunder Client (for API testing)

2. **Version Control**: Familiarity with Git and GitHub workflows

3. **Database**: PostgreSQL for local development

## 📋 Development Guidelines

### Code Style

- **JavaScript/TypeScript**: Follow ESLint configuration provided in the project
- **React/React Native**: Use functional components with hooks
- **Naming Conventions**:
  - Variables and functions: `camelCase`
  - Components: `PascalCase`
  - Constants: `UPPER_SNAKE_CASE`
  - Files: `kebab-case` for utilities, `PascalCase` for components

### Commit Messages

Use conventional commits format:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

Examples:
```
feat(auth): add password reset functionality
fix(api): resolve authentication token expiration
docs(readme): update setup instructions
```

### Branch Naming

- Feature branches: `feature/description-of-feature`
- Bug fixes: `fix/description-of-bug`
- Documentation: `docs/description-of-changes`
- Hotfixes: `hotfix/critical-fix-description`

## 🔄 Workflow

### 1. Fork and Clone

```bash
# Fork the repository on GitHub
git clone https://github.com/your-username/parfly.git
cd parfly
git remote add upstream https://github.com/original-owner/parfly.git
```

### 2. Create a Branch

```bash
git checkout -b feature/your-feature-name
```

### 3. Make Changes

- Write clean, documented code
- Follow existing code patterns
- Add tests for new functionality
- Update documentation as needed

### 4. Test Your Changes

#### Backend Testing
```bash
cd Parfly-Backend
npm test  # Run tests (when available)
npm run dev  # Start development server
```

#### Frontend Testing
```bash
cd Parfly-Admin
npm run dev  # Test admin panel
```

#### Mobile Testing
```bash
cd Parfly-Customer-App
npx expo start  # Test on device/emulator
```

### 5. Commit and Push

```bash
git add .
git commit -m "feat(component): add new feature"
git push origin feature/your-feature-name
```

### 6. Create Pull Request

1. Go to the GitHub repository
2. Click "New Pull Request"
3. Select your branch
4. Fill out the PR template
5. Submit for review

## 📱 Component-Specific Guidelines

### Backend (Node.js/Express)

- **Structure**: Follow MVC pattern (Models, Views, Controllers)
- **Error Handling**: Always implement proper error handling
- **Validation**: Validate all inputs
- **Security**: Follow security best practices
- **Database**: Use parameterized queries to prevent SQL injection

```javascript
// Example controller structure
export const createDelivery = async (req, res) => {
  try {
    // Validate input
    const { error } = validateDeliveryInput(req.body);
    if (error) return res.status(400).json({ message: error.details[0].message });
    
    // Business logic
    const delivery = await deliveryService.create(req.body);
    
    // Response
    res.status(201).json(delivery);
  } catch (error) {
    console.error('Error creating delivery:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};
```

### Frontend (React)

- **Components**: Create reusable, single-purpose components
- **State Management**: Use appropriate state management (useState, useContext, Zustand)
- **Performance**: Implement memoization where needed
- **Accessibility**: Ensure components are accessible

```jsx
// Example component structure
import React, { useState, useEffect } from 'react';

const DeliveryCard = ({ delivery, onUpdate }) => {
  const [isLoading, setIsLoading] = useState(false);
  
  const handleUpdate = async () => {
    setIsLoading(true);
    try {
      await onUpdate(delivery.id);
    } catch (error) {
      console.error('Update failed:', error);
    } finally {
      setIsLoading(false);
    }
  };
  
  return (
    <div className="delivery-card">
      {/* Component content */}
    </div>
  );
};

export default DeliveryCard;
```

### Mobile (React Native/Expo)

- **Navigation**: Use Expo Router for navigation
- **Performance**: Optimize for mobile performance
- **Platform Differences**: Handle iOS/Android differences
- **Permissions**: Request permissions appropriately

```tsx
// Example mobile component
import React from 'react';
import { View, Text, TouchableOpacity } from 'react-native';

interface DeliveryItemProps {
  delivery: Delivery;
  onPress: (id: string) => void;
}

const DeliveryItem: React.FC<DeliveryItemProps> = ({ delivery, onPress }) => {
  return (
    <TouchableOpacity onPress={() => onPress(delivery.id)}>
      <View>
        <Text>{delivery.title}</Text>
      </View>
    </TouchableOpacity>
  );
};

export default DeliveryItem;
```

## 🐛 Bug Reports

When reporting bugs, please include:

1. **Environment**: OS, browser, device type
2. **Steps to reproduce**: Clear, numbered steps
3. **Expected behavior**: What should happen
4. **Actual behavior**: What actually happens
5. **Screenshots**: If applicable
6. **Console logs**: Any error messages

## 💡 Feature Requests

When suggesting features:

1. **Use case**: Describe the problem it solves
2. **Proposed solution**: How it should work
3. **Alternatives**: Other solutions considered
4. **Implementation**: Technical approach (if known)

## 📚 Documentation

- Update README.md for setup changes
- Add JSDoc comments for functions
- Update API documentation for backend changes
- Include code examples for new features

## 🔍 Code Review Process

### For Contributors

- Ensure your code follows the style guidelines
- Add tests for new functionality
- Update documentation
- Keep PRs focused and small

### For Reviewers

- Check code quality and style
- Verify functionality works as expected
- Ensure proper error handling
- Validate security considerations

## 🏗️ Project Structure Understanding

```
Parfly-Backend/
├── controllers/     # Handle HTTP requests
├── services/       # Business logic
├── routes/         # API endpoint definitions
├── middleware/     # Custom middleware
└── utils/          # Utility functions

Parfly-Admin/
├── src/
│   ├── admin/      # Admin dashboard pages
│   ├── client/     # Public landing pages
│   ├── auth/       # Authentication components
│   ├── layouts/    # Page layouts
│   └── assets/     # Static assets

Parfly-Customer-App/
├── app/            # App screens (Expo Router)
├── components/     # Reusable components
├── hooks/          # Custom hooks
├── store/          # State management
└── utils/          # Utility functions
```

## 🚦 Testing Guidelines

- Write unit tests for utility functions
- Integration tests for API endpoints
- Component tests for React components
- E2E tests for critical user flows

## 📞 Getting Help

- **Issues**: Create a GitHub issue
- **Discussions**: Use GitHub discussions for questions
- **Discord**: Join our development Discord (if available)

## 📄 License

By contributing to Parfly, you agree that your contributions will be licensed under the same license as the project (MIT License).

---

Thank you for contributing to Parfly! 🚀

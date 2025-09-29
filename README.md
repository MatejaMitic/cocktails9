# Table of Contents
- [Project Overview](#project-overview)  
- [Key Features](#key-features)  
- [Core Components and Technical Deep Dive](#core-components-and-technical-deep-dive)  
  1. [UI & Navigation](#1-ui--navigation)  
  2. [Authentication (Login & Register)](#2-authentication-login--register)  
  3. [Cocktail Data Model & Favorites](#3-cocktail-data-model--favorites)  
  4. [API / Networking](#4-api--networking)  
  5. [Search & Filtering](#5-search--filtering)  
- [Example Usage](#example-usage)  

---

## Project Overview
**cocktails9** is an iOS mobile application developed during a *Mobile Development Internship at Levi9*.  
The app allows users to register/login, browse a cocktail catalog, search and filter drinks, and save favorite cocktails.  

---

## Key Features
- **User Authentication**: Login & Register flow for personalized experience  
- **Cocktail Catalog**: Browse cocktail recipes with images and details  
- **Favorites**: Mark and store favorite drinks for quick access  
- **Search & Filtering**: Find cocktails by name, ingredient, or category  
- **Networking**: Fetch cocktail data dynamically from API  
- **Modern UI**: Intuitive, mobile-friendly design with smooth navigation  

---

## Core Components and Technical Deep Dive

### 1. UI & Navigation
- Implemented in **Swift (UIKit/SwiftUI)**  
- Structured navigation: login → list of cocktails → detail view → favorites  
- Supports responsive layouts and smooth transitions  

### 2. Authentication (Login & Register)
- Users can create an account or log in with existing credentials  
- Credentials validation and error handling included  
- Session handling to keep users signed in  

### 3. Cocktail Data Model & Favorites
- `Cocktail` model holds recipe data (id, name, ingredients, instructions, imageURL)  
- Favorites are stored locally so users can persist their selections  
- Efficient lookup and retrieval for saved drinks  

### 4. API / Networking
- REST API calls for retrieving cocktail recipes  
- JSON parsing into `Cocktail` models  
- Handles loading states and network errors gracefully  

### 5. Search & Filtering
- Dynamic search with live filtering as the user types  
- Filters by cocktail name, category, or main ingredient  
- Optimized to handle larger cocktail datasets  

---

## Example Usage
```swift
// Login/Register
AuthService.shared.login(email: "user@mail.com", password: "123456")

// Fetch cocktails
CocktailService.shared.fetchAll { cocktails in
    print("Loaded \(cocktails.count) cocktails")
}

// Add to favorites
FavoritesManager.shared.add(cocktail)

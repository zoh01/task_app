# 📰 Flutter Task App

## 📌 Introduction
This Flutter Task App was developed as part of a coding assessment and learning project.  
The main objective was to demonstrate my understanding of Flutter architecture, state management, and UI design principles while building a functional and visually appealing task management application.

---

## 📋 Overview
This is a simple Flutter app that allows users to manage daily tasks efficiently.  
Users can:
- Add new tasks with a title and optional notes  
- Edit or delete existing tasks  
- Toggle between light and dark themes  
- View the creation date and time of each task  

The app provides a clean, intuitive user interface and stores all data locally on the device.

---

## 🔍 My Approach
To ensure clean organization and scalability, I structured the app using a **three-layer architecture**:
- **Data Layer:** Handles local storage using Hive (for saving tasks permanently on the device).  
- **Domain Layer:** Defines the data model (`ItemModel`) that represents a task.  
- **Presentation Layer:** Contains all the UI elements — screens, widgets, buttons, dialogs, and animations.

For state management, I used the **Provider** package to efficiently update the user interface whenever data changes.  
A **theme toggle** feature was added for a modern, customizable experience.

---

## 🛠️ Tools & Libraries Used
- **provider** – State management for theme and tasks  
- **hive & hive_flutter** – Local database for storing tasks  
- **uuid** – Generates unique task IDs  
- **intl** – Date and time formatting  
- **google_fonts** – Custom typography for UI  
- **flutter_switch** – Custom light/dark mode toggle  
- **animate_do** – Smooth UI animations  
- **animated_text_kit** – Animated text for splash and transitions

---

## 🧭 How It Works

The app follows a **Clean Architecture pattern**, separating code into three main layers:

### 1️⃣ Data Layer
- Handles local data storage using **Hive**.
- Includes the `ItemProvider` class, which manages CRUD operations (Create, Read, Update, Delete).
- Every new task gets a unique ID using **uuid**.

### 2️⃣ Domain Layer
- Contains the `ItemModel`, which defines the structure of a task (title, description, creation date, etc.).
- Keeps the app’s logic separate from the UI.

### 3️⃣ Presentation Layer
- Includes all UI screens and widgets.
- **Home Screen:** Displays all saved tasks.
- **Add/Edit Screen:** Allows users to add or modify tasks.
- **Item Tile Widget:** Displays each task beautifully with date and note.
- **Delete Dialog:** Confirms before removing a task.
- **Theme Switch:** Lets users toggle between dark and light modes using a custom **flutter_switch**.

### 🌀 Data Flow
1. User adds a new task → `ItemProvider` saves it to **Hive**.
2. Provider notifies the UI → the new task appears instantly.
3. User can edit or delete → Provider updates/deletes the data in Hive.
4. Theme toggle → changes are applied app-wide using **ThemeProvider**.

---

### 🎨 Design Approach
- Used **Google Fonts** for modern typography.
- Applied **consistent spacing and rounded corners** for a clean interface.
- Integrated **light/dark themes** to improve usability.
- Added smooth animations with **animate_do** for visual polish.

---

## 📱 App Preview

### Splash Screen
![Splash](https://github.com/zoh01/task_app/blob/9e35fed7875547a0f662ea73ac08466290d1c332/splash.jpeg)

### Empty State
![Empty](https://github.com/zoh01/task_app/blob/9e35fed7875547a0f662ea73ac08466290d1c332/empty.jpeg)

### Add Task
![Add Task](https://github.com/zoh01/task_app/blob/9e35fed7875547a0f662ea73ac08466290d1c332/add_task.jpeg)

### Task List
![List](https://github.com/zoh01/task_app/blob/9e35fed7875547a0f662ea73ac08466290d1c332/list.jpeg)

### Dark Mode
![Dark Mode](https://github.com/zoh01/task_app/blob/9e35fed7875547a0f662ea73ac08466290d1c332/dark_mode.jpeg)

### Delete Task
![Delete Task](https://github.com/zoh01/task_app/blob/9e35fed7875547a0f662ea73ac08466290d1c332/delete_task.jpeg)

---

## How to Run the Project
1. Clone the repository:
   
         git clone <https://github.com/zoh01/task_app>

2. Enter project folder
   
       cd task_app

3. Get dependencies
  
       flutter pub get

4. Run the app
  
       flutter run

---

## 👤 Author
### Adebayo Wariz  

## 📧 Contact
Whatsapp: +234 702 513 6608

Email: adebayozoh@gmail.com

LinkedIn: https://www.linkedin.com/in/adebayo-wariz-a8ab9a310/

GitHub: [https://github.com/zoh01](https://github.com/zoh01)

---

## 📄 License
   
This project is licensed under the MIT License - see [LICENSE](#-LICENSE) file.

    MIT License
    
    Copyright (c) 2025 [Adebayo Wariz]
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction...

# CRUD Posts App

## Overview
This iOS mobile app is designed to allow users to easily interact with posts through a clean and user-friendly interface. 
Users can view, edit, delete, and create new posts using an MVVM architecture.
The app displays posts in a list with small circular images and titles. Users can tap on any post to view its details on a separate page and either edit or delete it. A button on the home page allows for adding new posts by entering an image, title, and message.

## Features
- **View Posts**: Display all posts in a list with a circular image and title.
- **Post Details**: Clicking on a post shows its details, allowing editing or deletion.
- **Create Post**: Add new posts using a dialog with fields for image, title, and message.
- **Edit Post**: Modify an existing post’s title, message, or image.
- **Delete Post**: Remove an existing post.

## API Integration
The app communicates with a remote server using the API endpoints:

- **Get all posts** 
- **Create post**
- **Update post**  
- **Delete post**:  
 
  **Response**: Done/Failed.

## Design Pattern
- **MVVM (Model-View-ViewModel)** is used to separate the logic from the UI, making the code more modular and easier to test.

## External Packages Used
- No 3rd party packages used.
  
## Custom Networking
Instead of relying on third-party libraries, I implemented custom network code for API interactions using `URLSession` for an extra point. This adds more flexibility and control over the networking behavior and reduces external dependencies.

## How to run the app
1. Clone the repository from GitHub:
   ```bash
   git clone https://github.com/shadyadel90/CRUDPosts.git
   ```
2. Open the project in Xcode.
3. Run the app on a simulator or a physical device.
4. Make sure the device is connected to the internet to interact with the API.

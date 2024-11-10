### Steps to Run the App
	1.	Clone the repository to your local machine.
	2.	Open RecipeApp.xcodeproj in Xcode (version 14 or later).
	3.	Ensure your selected build target is iOS 16.0 or later.
	4.	Run the app on a simulator or connected device by pressing ⌘R.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
1. Architecture:
I prioritized a clean and scalable architecture by using MVVM (Model-View-ViewModel), making the code modular and testable. The networking layer is abstracted, allowing for easy modifications or expansions. I also integrated Swift’s @Published properties in the ViewModels to drive UI updates based on state changes.

2. Concurrency:
To handle API requests efficiently, I leveraged Swift’s concurrency model with async/await. This approach keeps the UI responsive, improves readability, and simplifies error handling. I used structured concurrency for organized, error-resistant handling of multiple async tasks.

3. UI/UX:
My focus on UI/UX ensured a clean, intuitive design. SwiftUI enabled a responsive, adaptable layout with clear sections for content. For elements like links and images, I prioritized accessibility, making the source and YouTube links interactive with visual cues to enhance user experience.

Truthfully, I could spend hours refining the UI/UX aspect of the app to make it seamless and beautiful, incorporating creative ideas to make it unique. At the same time, I realize that a great UI is of limited value if the app’s core functionality isn’t solid. I chose to focus on the core functionality first to ensure the app remains “usable” even with a simple UI.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent approximately 6 hours over the weekend on this project, including some breaks.
After an initial planning phase, I started coding, focusing mostly on implementing the MVVM architecture, connecting it with the networking layer, and developing the image caching service. Since I hadn’t worked on caching before, I had to rely on AI assistance to navigate this part, which was challenging but ultimately rewarding.
I spent the least amount of time on the UI and unit tests as a result.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I wouldn’t say I made specific trade-offs, but I did compromise on unit tests and the UI to an extent. For example, I could have implemented a sorting function to allow users to sort recipes. With better planning and time management, I think I could have achieved a more comprehensive solution.


### Weakest Part of the Project: What do you think is the weakest part of your project?
The weakest parts, in my opinion, are validation and testing. I don’t have extensive professional experience with iOS applications yet, but I tried my best to learn and implement things along the way. In my current role, I focus on core iOS system functions like background task scheduling, which has meant I haven’t kept my app-building skills as sharp as I’d like. Nonetheless, I aimed to produce a functional, well-coded app.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
URLSession: Used for networking to fetch recipes and images.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
With more time, I believe I could address the current shortcomings of the app. Most of my abilities are reflected in the code I’ve written. I’m grateful for this assessment, as it helped me learn new concepts that I plan to refine and perfect soon.

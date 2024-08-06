# Introduction

In [BrainSoup](https://www.nurgo-software.com/products/brainsoup), **Hooks** provide a powerful mechanism to extend and customize the platform's functionality by allowing users to trigger the execution of programs or scripts in response to specific internal events. This feature is highly versatile and can be implemented using any programming language executable on the host machine, making it accessible to a wide range of users with different technical backgrounds.

# What are Hooks?

Hooks in BrainSoup are essentially executable files that are triggered by predefined events within the system. These events could be anything from periodic timers to specific actions taken by agents or users. By leveraging hooks, you can automate various tasks, update Custom Contexts, send Custom Events, or even interact with external systems seamlessly.

# How to Create and Use Hooks

## Step 1: Locate the Hooks Folder

The first step in creating a hook is to navigate to the `Hooks` folder within your BrainSoup installation directory. This folder is organized into sub-folders, each corresponding to a specific event that can trigger hooks.

**Tip:** You can quickly access the `Hooks` folder from the BrainSoup interface by going to _Settings > App Folders > Hooks_.

## Step 2: Understand the Folder Structure

The `Hooks` folder contains sub-folders named after the events they correspond to. For example:

- `Hooks\OnEvent\Timer.EveryHour\`
- `Hooks\OnEvent\Clock.8AM\`
- `Hooks\OnEvent\FileSystem.Created\`
- `Hooks\OnEvent\Application.Status\`
- `Hooks\OnEvent\OperatingSystem.UserPresence\`

Each of these sub-folders represents an event in BrainSoup. When an event occurs, all executable files within the corresponding sub-folder are triggered.

**Tip:** Hooks can also be triggered by **Custom Events** that you can send by placing small JSON files in the `Event\` folder. As soon as a new Custom Event type is detected, BrainSoup will create a new sub-folder for it in the `Hooks\OnEvent\` directory.

## Step 3: Create Your Hook

To create a hook:

1. Choose the appropriate sub-folder based on the event you want to trigger your script.
2. Place your executable file (script or program) inside this sub-folder.

For instance, if you want to run a script every hour, place your script in the `Hooks\OnEvent\Timer.EveryHour\` folder.

## Example Usage

Let's say you want to periodically update Custom Contexts every hour. You could write a script that fetches new data and updates your context files accordingly. Place this script in `Hooks\OnEvent\Timer.EveryHour\`, and BrainSoup will execute it every hour automatically.

# Practical Applications

Here are some practical applications of hooks:

- **Updating Custom Contexts**: Automatically refresh dynamic data used by agents.
- **Sending Custom Events**: Send special _Event_ messages to chat rooms to which agents can react.
- **Interacting with External Systems**: Integrate with other software or services by executing API calls or other interactions.

# Conclusion

BrainSoup's Hooks feature provides a flexible and powerful way to extend the platform's capabilities through automation and integration. By understanding how to create and use hooks effectively, you can significantly enhance your workflow and make your BrainSoup environment more responsive and tailored to your needs.
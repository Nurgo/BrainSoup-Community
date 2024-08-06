# Tools

In BrainSoup, a **Tool** is a set of **functions** that an agent can utilize to perform specific tasks or operations.

Tools can be enabled or disabled for each agent individually, or at the chat room level. This allows for fine-grained control over the capabilities of the agents.

These tools can be simple, such as a calculator for performing mathematical calculations, or more complex like HTTP tools for making network requests. But tools are not limited to what comes pre-packaged with the software.

Users have the ability to add new tools, extending the capabilities of their agents and enhancing their interaction with external environments. This could involve anything from running scripts on the local host, interacting with databases, managing files, to even integrating with other APIs or software.

There are 3 types of tools in BrainSoup: Built-in Tools, OpenAI Plugins and Custom Tools.

# Custom Tools

In BrainSoup, **Custom Tools** are user-created tools that run commands on the local machine. These are defined by a file named `manifest.json` located in a subfolder of `Tools/Custom`. Once a custom tool is added, it will be immediately recognized by BrainSoup, and will be available for activation at the agent or chat room level.


## Structure of a Custom Tool

The `manifest.json` file describes the tool and its functions. The first level of its structure is thus an array of functions, defined as follows:

- **Function properties:**
  - **name**: The name of the function.
  - **description**: A description of the function.
  - **parameters (optional)**: An array of parameters that the function accepts.
  - **command**: The command to be executed.
  - **timeout (optional)**: The maximum time in seconds that the command is allowed to run before it is terminated. If not specified, the default timeout is 10 seconds.
  - **workingDirectory (optional)**: The directory in which the command should be executed. If not specified, the command will be executed in the tool directory.
- **Parameter properties:**
  - **name**: The name of the parameter.
  - **description**: A description of the parameter.
  - **isRequired**: Whether the parameter is required or optional.
  - **defaultValue (optional)**: The default value of the parameter, if it is optional.


## Passing Parameters to a Custom Tool

Parameters can be used in the command by enclosing them in double curly braces. For example, if a parameter named `destination` is defined, it can be used in the command as `{{destination}}`. The command will be executed with the parameters replaced by their values. Parameters are also injected into the environment variables of the created process. For example, if a parameter named `FileContent` is defined, it will be available in the `ARGS_FILECONTENT` environment variable.


## Example of a Custom Tool

Here's an example of what a `manifest.json` might look like for a simple custom tool that sends a ping request:

```json
{
  "functions": [
    {
      "name": "Send",
      "description": "Send ICMP ECHO_REQUEST datagram to host",
      "parameters": [
        {
          "name": "destination",
          "description": "IP address or host name",
          "isRequired": true
        }
      ],
      "command": "ping {{destination}}",
      "timeout": 25
    }
  ]
}
```

In this example, the tool has one function named `Send`, which sends an ICMP ECHO_REQUEST (ping) to a specified destination. The destination is provided as a parameter, which is required for the function to work.

This tool would use whatever command line interpreter is available on your system (such as cmd or bash) to execute the `ping` command with the provided destination.


Tips:
- Name and description are crucial for the tool to be easily identifiable and understandable by the agents. They should be clear, concise and in English.
- If your script requires configuration, a good practice is to place it in a separate `config` file (with the appropriate extension) next to the script.
- If your command needs to be run in a directory other than the tool directory, you can set `workingDirectory`.
- You can set `defaultValue` for a parameter if it is not required.
- Arguments are also injected into the environment variables of the created process (useful for multi-line arguments). Example: `FileContent` argument will be available in `ARGS_FILECONTENT` environment variable.
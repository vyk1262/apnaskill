const fs = require("fs");
const path = require("path");

/**
 * Creates folders and JSON files based on a structured JavaScript object.
 * The data structure is expected to be an object where keys are folder names
 * and values are arrays of strings representing file names within those folders.
 * Each file will contain a JSON structure with a 'topic' field.
 *
 * @param {object} dataStructure - The JavaScript object containing the folder and file structure.
 * @param {string} outputDir - The base directory where the 'jsonFiles' folder will be created.
 */

const realJsonData = {
  "Java Programming": [
    "java_intro",
    "java_oops",
    "java_collections",
    "java_exceptions",
    "java_streams",
    "java_multithreading",
    "java_advanced",
    "java_applications",
    "java_security",
    "java_deployment",
  ],
};

const outputDir = "."; // Current directory

function createJsonFilesFromObject(dataStructure, outputDir = ".") {
  // Define the base directory where all JSON files and folders will reside
  const baseJsonFilesDir = path.join(outputDir, "allJsonFiles");

  // Create the base 'jsonFiles' directory if it doesn't exist
  if (!fs.existsSync(baseJsonFilesDir)) {
    fs.mkdirSync(baseJsonFilesDir, { recursive: true });
    console.log(`Created base directory: ${baseJsonFilesDir}`);
  }

  // Iterate over the keys (which will be folder names) in the provided data structure
  for (const folderName in dataStructure) {
    // Ensure the property belongs to the object itself, not its prototype chain
    if (Object.hasOwnProperty.call(dataStructure, folderName)) {
      const fileNames = dataStructure[folderName]; // Get the array of file names for the current folder

      // Use the folder name as is, without sanitization for spaces
      const currentFolderDir = path.join(baseJsonFilesDir, folderName);

      // Create the specific folder if it doesn't exist
      if (!fs.existsSync(currentFolderDir)) {
        fs.mkdirSync(currentFolderDir, { recursive: true });
        console.log(`Created directory: ${currentFolderDir}`);
      }

      // Iterate over the file names within the current folder's array
      fileNames.forEach((fileName) => {
        if (fileName) {
          // Ensure the file name is not empty
          // Define the content structure for each JSON file
          const data = {
            result: [
              {
                topic: fileName, // The topic will be the file name
                questions: [], // Empty array for questions as per your requirement
              },
            ],
          };

          // Sanitize the file name to be filesystem-friendly (replace spaces with underscores)
          const sanitizedFileName = fileName.replace(/ /g, "_");
          // Construct the full filename with .json extension
          const filename = `${sanitizedFileName}.json`;
          // Construct the full path to save the file inside its respective folder
          const filepath = path.join(currentFolderDir, filename);

          try {
            // Convert the data object to a pretty-printed JSON string
            const jsonData = JSON.stringify(data, null, 4);
            // Write the JSON data to the file
            fs.writeFileSync(filepath, jsonData, "utf-8");
            console.log(`Created: ${filepath}`);
          } catch (error) {
            console.error(`Error creating file ${filepath}: ${error.message}`);
          }
        }
      });
    }
  }
}

// Call the function to create the folders and JSON files using the embedded data
createJsonFilesFromObject(realJsonData, outputDir);
